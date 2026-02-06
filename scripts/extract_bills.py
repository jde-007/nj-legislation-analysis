#!/usr/bin/env python3
"""
Extract bills from NJ Legislature bulk data and create analysis files.
"""

import csv
import json
import os
from pathlib import Path
from datetime import datetime

DATA_DIR = Path(__file__).parent.parent / 'njleg-data'
OUTPUT_DIR = Path(__file__).parent.parent

def load_table(filename):
    """Load a delimited text file into list of dicts."""
    filepath = DATA_DIR / filename
    rows = []
    with open(filepath, 'r', encoding='utf-8', errors='replace') as f:
        reader = csv.DictReader(f)
        for row in reader:
            rows.append(row)
    return rows

def search_bills(bills, keywords, fields=['Synopsis', 'Abstract']):
    """Search bills by keywords."""
    results = []
    keywords_lower = [k.lower() for k in keywords]
    
    for bill in bills:
        text = ' '.join(str(bill.get(f, '')) for f in fields).lower()
        if any(kw in text for kw in keywords_lower):
            results.append(bill)
    return results

def get_bill_subjects(bill_num, bill_type, subjects_table, headings_table):
    """Get subject categories for a bill."""
    subjects = []
    for subj in subjects_table:
        if subj.get('BillNumber') == bill_num and subj.get('BillType', '').strip() == bill_type.strip():
            subj_key = subj.get('SubjectKey', '')
            # Look up full subject name
            for heading in headings_table:
                if heading.get('SubjAbbrev') == subj_key:
                    subjects.append(heading.get('Desc', subj_key))
                    break
            else:
                subjects.append(subj_key)
    return subjects

def get_bill_sponsors(bill_num, bill_type, sponsors_table):
    """Get sponsors for a bill."""
    sponsors = []
    for spon in sponsors_table:
        if spon.get('BillNumber') == bill_num and spon.get('BillType', '').strip() == bill_type.strip():
            name = spon.get('LegName', '').strip()
            rank = spon.get('Rank', '')
            if name:
                sponsors.append({'name': name, 'rank': rank})
    return sorted(sponsors, key=lambda x: int(x['rank']) if x['rank'].isdigit() else 99)

def get_bill_history(bill_num, bill_type, history_table):
    """Get action history for a bill."""
    history = []
    for hist in history_table:
        if hist.get('BillNumber') == bill_num and hist.get('BillType', '').strip() == bill_type.strip():
            history.append({
                'date': hist.get('Date', ''),
                'action': hist.get('Action', ''),
                'committee': hist.get('Committee', ''),
            })
    return sorted(history, key=lambda x: x['date'])

def format_bill_markdown(bill, subjects, sponsors, history):
    """Format a bill as markdown."""
    bill_id = f"{bill['BillType'].strip()}{bill['BillNumber']}"
    
    md = f"# {bill_id}\n\n"
    md += f"**Synopsis:** {bill.get('Synopsis', 'N/A')}\n\n"
    md += f"**Abstract:** {bill.get('Abstract', 'N/A')}\n\n"
    
    md += "## Details\n\n"
    md += f"- **Status:** {bill.get('CurrentStatus', 'Unknown')}\n"
    md += f"- **Introduced:** {bill.get('IntroDate', 'Unknown')[:10] if bill.get('IntroDate') else 'Unknown'}\n"
    md += f"- **Last Action:** {bill.get('LDOA', 'Unknown')[:10] if bill.get('LDOA') else 'Unknown'}\n"
    
    if bill.get('GovernorAction'):
        md += f"- **Governor Action:** {bill.get('GovernorAction')} ({bill.get('GovernorDateOfAction', '')[:10]})\n"
    if bill.get('ChapterLaw'):
        md += f"- **Chapter Law:** {bill.get('ChapterLaw')}\n"
    
    md += f"\n## Sponsors\n\n"
    for spon in sponsors[:10]:  # Top 10 sponsors
        md += f"- {spon['name']}\n"
    
    if subjects:
        md += f"\n## Subjects\n\n"
        for subj in subjects:
            md += f"- {subj}\n"
    
    if history:
        md += f"\n## History\n\n"
        md += "| Date | Action | Committee |\n"
        md += "|------|--------|----------|\n"
        for h in history[-15:]:  # Last 15 actions
            date = h['date'][:10] if h['date'] else ''
            md += f"| {date} | {h['action'][:50]} | {h['committee']} |\n"
    
    md += f"\n## Source\n\n"
    md += f"**URL:** https://www.njleg.state.nj.us/bill-search/2024/{bill_id}\n"
    
    return md

def extract_hearing_bills(hearing_dir, keywords, hearing_date):
    """Extract bills relevant to a hearing."""
    print(f"Loading bill data...")
    bills = load_table('MAINBILL.TXT')
    subjects_table = load_table('BILLSUBJ.TXT')
    headings_table = load_table('SUBJHEADINGS.TXT')
    sponsors_table = load_table('BILLSPON.TXT')
    history_table = load_table('BILLHIST.TXT')
    
    print(f"Searching for bills with keywords: {keywords}")
    matching_bills = search_bills(bills, keywords)
    print(f"Found {len(matching_bills)} matching bills")
    
    bills_dir = hearing_dir / 'bills'
    bills_dir.mkdir(exist_ok=True)
    
    # Create individual bill files
    bill_summaries = []
    for bill in matching_bills:
        bill_id = f"{bill['BillType'].strip()}{bill['BillNumber']}"
        bill_type = bill['BillType'].strip()
        bill_num = bill['BillNumber']
        
        subjects = get_bill_subjects(bill_num, bill_type, subjects_table, headings_table)
        sponsors = get_bill_sponsors(bill_num, bill_type, sponsors_table)
        history = get_bill_history(bill_num, bill_type, history_table)
        
        # Write individual bill file
        md = format_bill_markdown(bill, subjects, sponsors, history)
        bill_file = bills_dir / f"{bill_id}.md"
        with open(bill_file, 'w') as f:
            f.write(md)
        
        # Collect summary
        bill_summaries.append({
            'id': bill_id,
            'synopsis': bill.get('Synopsis', ''),
            'status': bill.get('CurrentStatus', ''),
            'intro_date': bill.get('IntroDate', '')[:10] if bill.get('IntroDate') else '',
            'sponsors': [s['name'] for s in sponsors[:3]],
            'subjects': subjects[:5],
        })
        
        print(f"  Wrote {bill_file.name}")
    
    # Write summary index
    index_md = f"# Bills Related to Hearing\n\n"
    index_md += f"**Hearing Date:** {hearing_date}\n"
    index_md += f"**Keywords:** {', '.join(keywords)}\n"
    index_md += f"**Bills Found:** {len(bill_summaries)}\n\n"
    
    index_md += "## Bill Index\n\n"
    index_md += "| Bill | Status | Synopsis | Primary Sponsor |\n"
    index_md += "|------|--------|----------|----------------|\n"
    
    for b in sorted(bill_summaries, key=lambda x: x['id']):
        sponsor = b['sponsors'][0] if b['sponsors'] else 'N/A'
        synopsis = b['synopsis'][:60] + '...' if len(b['synopsis']) > 60 else b['synopsis']
        index_md += f"| [{b['id']}]({b['id']}.md) | {b['status']} | {synopsis} | {sponsor} |\n"
    
    with open(bills_dir / 'INDEX.md', 'w') as f:
        f.write(index_md)
    
    # Write JSON for programmatic access
    with open(bills_dir / 'bills.json', 'w') as f:
        json.dump(bill_summaries, f, indent=2)
    
    return bill_summaries

if __name__ == '__main__':
    # Plastic pollution hearing
    print("\n=== PLASTIC POLLUTION HEARING (2024-04-22) ===\n")
    plastic_dir = OUTPUT_DIR / 'nj-2024-04-22-plastic-pollution'
    plastic_keywords = ['plastic', 'microplastic', 'polystyrene', 'recycl', 'single-use', 'packaging']
    extract_hearing_bills(plastic_dir, plastic_keywords, '2024-04-22')
    
    # Climate resiliency hearing
    print("\n=== CLIMATE RESILIENCY HEARING (2024-08-01) ===\n")
    climate_dir = OUTPUT_DIR / 'nj-2024-08-01-climate-resiliency'
    climate_keywords = ['climate', 'resilien', 'flood', 'sea level', 'coastal', 'storm', 'adaptation']
    extract_hearing_bills(climate_dir, climate_keywords, '2024-08-01')
