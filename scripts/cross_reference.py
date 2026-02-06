#!/usr/bin/env python3
"""
Cross-reference hearing testimony with bill language.
Find testimony claims that were adopted or ignored in legislation.
"""

import json
import re
from pathlib import Path
from difflib import SequenceMatcher

# Key testimony themes from plastic pollution hearing
PLASTIC_TESTIMONY_THEMES = [
    {
        'id': 'microplastics-testing',
        'witness': 'Dr. Phoebe Stapleton',
        'claim': 'Microplastics found in drinking water, need testing standards',
        'keywords': ['microplastic', 'drinking water', 'testing', 'identification'],
        'recommendation': 'DEP should adopt regulations for microplastic identification and testing',
    },
    {
        'id': 'nanoplastics-health',
        'witness': 'Dr. Phoebe Stapleton',
        'claim': 'Nanoplastics cross placental barrier, found in fetal tissues',
        'keywords': ['nanoplastic', 'placenta', 'fetal', 'health', 'maternal'],
        'recommendation': 'Research funding for health impacts',
    },
    {
        'id': 'phthalate-syndrome',
        'witness': 'Dr. Shanna Swan',
        'claim': 'Phthalate exposure causes reproductive harm (Phthalate Syndrome)',
        'keywords': ['phthalate', 'reproductive', 'fertility', 'endocrine', 'hormone'],
        'recommendation': 'Restrict phthalates in consumer products',
    },
    {
        'id': 'recycling-rates',
        'witness': 'Judith Enck',
        'claim': 'Only 5-6% of plastics actually recycled',
        'keywords': ['recycl', 'rate', 'percent'],
        'recommendation': 'Focus on reduction, not recycling',
    },
    {
        'id': 'bottle-bill',
        'witness': 'Judith Enck',
        'claim': 'Bottle deposit systems achieve 5x higher recycling rates',
        'keywords': ['bottle', 'deposit', 'container', 'redemption'],
        'recommendation': 'Pass bottle deposit legislation',
    },
    {
        'id': 'epr-packaging',
        'witness': 'Multiple',
        'claim': 'Extended Producer Responsibility shifts costs to manufacturers',
        'keywords': ['producer responsibility', 'EPR', 'manufacturer', 'packaging'],
        'recommendation': 'Pass EPR legislation for packaging',
    },
    {
        'id': 'chemical-recycling',
        'witness': 'Judith Enck',
        'claim': 'Chemical recycling has 1.3% yield, is mostly incineration',
        'keywords': ['chemical recycl', 'pyrolysis', 'advanced recycl'],
        'recommendation': 'Do not treat chemical recycling as true recycling',
    },
    {
        'id': 'single-use-reduction',
        'witness': 'Multiple',
        'claim': 'Single-use plastic bans are effective',
        'keywords': ['single-use', 'single use', 'ban', 'prohibition', 'carryout bag'],
        'recommendation': 'Maintain and expand single-use plastic restrictions',
    },
    {
        'id': 'packaging-reduction',
        'witness': 'Judith Enck',
        'claim': 'Packaging needs reduction targets like fuel efficiency standards',
        'keywords': ['packaging', 'reduction', 'target', 'standard'],
        'recommendation': 'Set mandatory packaging reduction standards',
    },
]

# Key testimony themes from climate resiliency hearing
CLIMATE_TESTIMONY_THEMES = [
    {
        'id': 'sea-level-projections',
        'witness': 'Dr. Anthony Broccoli',
        'claim': 'NJ sea level rise projections: 2.1 ft by 2050, 5.1 ft by 2100',
        'keywords': ['sea level', 'rise', 'projection', 'feet', '2050', '2100'],
        'recommendation': 'Use science-based projections for planning',
    },
    {
        'id': 'storm-surge-modeling',
        'witness': 'Dr. Ning Lin',
        'claim': 'Storm surge + sea level rise creates compound flood risk',
        'keywords': ['storm surge', 'compound', 'flood', 'hurricane'],
        'recommendation': 'Integrate storm surge models into planning',
    },
    {
        'id': 'coastal-engineering',
        'witness': 'Dr. Thomas Herrington',
        'claim': 'Beach nourishment provides $1.3B in storm damage savings (Sandy)',
        'keywords': ['beach', 'nourishment', 'coastal', 'engineer', 'protection'],
        'recommendation': 'Continue coastal protection investments',
    },
    {
        'id': 'blue-acres',
        'witness': 'Multiple',
        'claim': 'Managed retreat/buyout programs successful post-Sandy',
        'keywords': ['blue acres', 'buyout', 'retreat', 'acquisition', 'flood-prone'],
        'recommendation': 'Expand Blue Acres program',
    },
    {
        'id': 'flood-disclosure',
        'witness': 'Dr. Ning Lin',
        'claim': 'Property buyers need flood risk information',
        'keywords': ['disclosure', 'property', 'flood risk', 'buyer', 'seller'],
        'recommendation': 'Require flood risk disclosure in real estate',
    },
    {
        'id': 'infrastructure-resilience',
        'witness': 'Multiple',
        'claim': 'Infrastructure must be designed for future climate',
        'keywords': ['infrastructure', 'resilient', 'design', 'standard', 'building code'],
        'recommendation': 'Update building codes for climate resilience',
    },
    {
        'id': 'climate-financing',
        'witness': 'Multiple',
        'claim': 'Climate adaptation requires dedicated funding',
        'keywords': ['financing', 'fund', 'investment', 'adaptation', 'mitigation'],
        'recommendation': 'Create climate resilience financing programs',
    },
    {
        'id': 'hazard-mitigation-plans',
        'witness': 'Multiple',
        'claim': 'Hazard mitigation plans need climate change integration',
        'keywords': ['hazard mitigation', 'plan', 'climate change', 'assessment'],
        'recommendation': 'Require climate change in hazard mitigation plans',
    },
]

def load_bills(bills_dir):
    """Load all bill markdown files."""
    bills = {}
    for f in bills_dir.glob('*.md'):
        if f.name == 'INDEX.md':
            continue
        bill_id = f.stem
        with open(f, 'r') as file:
            bills[bill_id] = file.read()
    return bills

def search_bill_for_theme(bill_text, theme):
    """Check if a bill matches a testimony theme."""
    text_lower = bill_text.lower()
    matches = []
    
    for keyword in theme['keywords']:
        if keyword.lower() in text_lower:
            matches.append(keyword)
    
    return matches

def analyze_cross_references(bills_dir, testimony_themes, hearing_name):
    """Analyze cross-references between testimony and bills."""
    bills = load_bills(bills_dir)
    
    results = {
        'hearing': hearing_name,
        'total_bills': len(bills),
        'themes': [],
    }
    
    for theme in testimony_themes:
        theme_result = {
            'id': theme['id'],
            'witness': theme['witness'],
            'claim': theme['claim'],
            'recommendation': theme['recommendation'],
            'matching_bills': [],
            'adopted': False,
            'ignored': True,
        }
        
        for bill_id, bill_text in bills.items():
            matches = search_bill_for_theme(bill_text, theme)
            if len(matches) >= 2:  # Require at least 2 keyword matches
                # Extract synopsis from bill
                synopsis_match = re.search(r'\*\*Synopsis:\*\* (.+?)(?:\n|$)', bill_text)
                synopsis = synopsis_match.group(1) if synopsis_match else 'N/A'
                
                status_match = re.search(r'- \*\*Status:\*\* (.+?)(?:\n|$)', bill_text)
                status = status_match.group(1) if status_match else 'Unknown'
                
                theme_result['matching_bills'].append({
                    'bill_id': bill_id,
                    'synopsis': synopsis[:100],
                    'status': status,
                    'matched_keywords': matches,
                })
                theme_result['ignored'] = False
                
                # Check if any bill was enacted
                if status in ['APP', 'Approved', 'LAW']:
                    theme_result['adopted'] = True
        
        results['themes'].append(theme_result)
    
    return results

def generate_cross_reference_report(results, output_path):
    """Generate markdown report of cross-references."""
    md = f"# Cross-Reference Analysis: {results['hearing']}\n\n"
    md += f"**Total Related Bills:** {results['total_bills']}\n\n"
    
    # Summary stats
    adopted_count = sum(1 for t in results['themes'] if t['adopted'])
    addressed_count = sum(1 for t in results['themes'] if not t['ignored'])
    ignored_count = sum(1 for t in results['themes'] if t['ignored'])
    
    md += "## Summary\n\n"
    md += f"| Metric | Count |\n"
    md += f"|--------|-------|\n"
    md += f"| Testimony Themes Analyzed | {len(results['themes'])} |\n"
    md += f"| Themes with Related Bills | {addressed_count} |\n"
    md += f"| Themes Potentially Enacted | {adopted_count} |\n"
    md += f"| Themes Not Addressed in Bills | {ignored_count} |\n\n"
    
    # Detailed theme analysis
    md += "## Theme-by-Theme Analysis\n\n"
    
    for theme in results['themes']:
        status_emoji = "✅" if theme['adopted'] else ("📋" if not theme['ignored'] else "❌")
        md += f"### {status_emoji} {theme['id'].replace('-', ' ').title()}\n\n"
        md += f"**Witness:** {theme['witness']}\n\n"
        md += f"**Claim:** {theme['claim']}\n\n"
        md += f"**Recommendation:** {theme['recommendation']}\n\n"
        
        if theme['matching_bills']:
            md += f"**Related Bills ({len(theme['matching_bills'])}):**\n\n"
            md += "| Bill | Status | Synopsis | Keywords Matched |\n"
            md += "|------|--------|----------|------------------|\n"
            for bill in theme['matching_bills'][:10]:  # Top 10
                keywords = ', '.join(bill['matched_keywords'][:3])
                md += f"| {bill['bill_id']} | {bill['status']} | {bill['synopsis'][:50]}... | {keywords} |\n"
            md += "\n"
        else:
            md += "**No directly related bills found.**\n\n"
        
        md += "---\n\n"
    
    # Adoption status legend
    md += "## Legend\n\n"
    md += "- ✅ **Adopted**: At least one related bill was enacted\n"
    md += "- 📋 **Addressed**: Related bills exist but not yet enacted\n"
    md += "- ❌ **Not Addressed**: No related bills found\n"
    
    with open(output_path, 'w') as f:
        f.write(md)
    
    return md

if __name__ == '__main__':
    base_dir = Path(__file__).parent.parent
    
    # Plastic pollution hearing
    print("Analyzing plastic pollution cross-references...")
    plastic_bills_dir = base_dir / 'nj-2024-04-22-plastic-pollution' / 'bills'
    plastic_results = analyze_cross_references(
        plastic_bills_dir, 
        PLASTIC_TESTIMONY_THEMES,
        'Plastic Pollution (April 22, 2024)'
    )
    generate_cross_reference_report(
        plastic_results,
        base_dir / 'nj-2024-04-22-plastic-pollution' / 'CROSS_REFERENCE.md'
    )
    print(f"  Generated CROSS_REFERENCE.md")
    
    # Save JSON
    with open(base_dir / 'nj-2024-04-22-plastic-pollution' / 'cross_reference.json', 'w') as f:
        json.dump(plastic_results, f, indent=2)
    
    # Climate resiliency hearing
    print("Analyzing climate resiliency cross-references...")
    climate_bills_dir = base_dir / 'nj-2024-08-01-climate-resiliency' / 'bills'
    climate_results = analyze_cross_references(
        climate_bills_dir,
        CLIMATE_TESTIMONY_THEMES,
        'Climate Resiliency (August 1, 2024)'
    )
    generate_cross_reference_report(
        climate_results,
        base_dir / 'nj-2024-08-01-climate-resiliency' / 'CROSS_REFERENCE.md'
    )
    print(f"  Generated CROSS_REFERENCE.md")
    
    # Save JSON
    with open(base_dir / 'nj-2024-08-01-climate-resiliency' / 'cross_reference.json', 'w') as f:
        json.dump(climate_results, f, indent=2)
    
    print("\nDone!")
