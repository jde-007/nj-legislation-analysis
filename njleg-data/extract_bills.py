#!/usr/bin/env python3
"""
Extract NJ Legislature bill data for hearing analysis.
Uses official bulk data from njleg.state.nj.us/downloads
"""

import csv
import sys
from pathlib import Path

def parse_mainbill(filepath):
    """Parse MAINBILL.TXT into structured data."""
    bills = []
    with open(filepath, 'r', encoding='utf-8', errors='replace') as f:
        reader = csv.DictReader(f)
        for row in reader:
            bills.append(row)
    return bills

def search_bills(bills, keywords, case_insensitive=True):
    """Search bills by keywords in synopsis or abstract."""
    results = []
    for bill in bills:
        text = f"{bill.get('Synopsis', '')} {bill.get('Abstract', '')}"
        if case_insensitive:
            text = text.lower()
            keywords = [k.lower() for k in keywords]
        
        if any(kw in text for kw in keywords):
            results.append(bill)
    return results

def format_bill(bill):
    """Format a bill for display."""
    bill_num = f"{bill['BillType'].strip()}{bill['BillNumber']}"
    status = bill.get('CurrentStatus', '?')
    sponsor = bill.get('FirstPrime', '').strip()
    synopsis = bill.get('Synopsis', '')[:100]
    intro = bill.get('IntroDate', '')[:10]
    
    return {
        'bill': bill_num,
        'status': status,
        'sponsor': sponsor,
        'intro_date': intro,
        'synopsis': synopsis,
        'full_synopsis': bill.get('Synopsis', ''),
        'abstract': bill.get('Abstract', ''),
    }

def main():
    data_dir = Path(__file__).parent
    mainbill_path = data_dir / 'MAINBILL.TXT'
    
    if not mainbill_path.exists():
        print(f"Error: {mainbill_path} not found")
        sys.exit(1)
    
    bills = parse_mainbill(mainbill_path)
    print(f"Loaded {len(bills)} bills from database")
    
    # Plastic-related bills
    print("\n" + "="*60)
    print("PLASTIC-RELATED BILLS (2024-2025 Session)")
    print("="*60)
    
    plastic_keywords = ['plastic', 'microplastic', 'polystyrene', 'recycl']
    plastic_bills = search_bills(bills, plastic_keywords)
    
    for bill in plastic_bills:
        b = format_bill(bill)
        print(f"\n{b['bill']} ({b['status']}) - {b['sponsor']}")
        print(f"  Intro: {b['intro_date']}")
        print(f"  {b['synopsis']}...")
    
    # Climate/resiliency bills
    print("\n" + "="*60)
    print("CLIMATE/RESILIENCY BILLS (2024-2025 Session)")
    print("="*60)
    
    climate_keywords = ['climate', 'resilien', 'flood', 'sea level', 'coastal']
    climate_bills = search_bills(bills, climate_keywords)
    
    for bill in climate_bills[:15]:  # First 15
        b = format_bill(bill)
        print(f"\n{b['bill']} ({b['status']}) - {b['sponsor']}")
        print(f"  Intro: {b['intro_date']}")
        print(f"  {b['synopsis']}...")
    
    print(f"\n... and {len(climate_bills) - 15} more climate/resiliency bills")
    
    # Summary
    print("\n" + "="*60)
    print("SUMMARY")
    print("="*60)
    print(f"Total bills in database: {len(bills)}")
    print(f"Plastic-related bills: {len(plastic_bills)}")
    print(f"Climate/resiliency bills: {len(climate_bills)}")

if __name__ == '__main__':
    main()
