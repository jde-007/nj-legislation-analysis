#!/usr/bin/env python3
"""
Download full text PDFs of NJ bills from pub.njleg.gov
Usage: python download_bills.py [--plastic] [--climate] [--bill A1481] [--all]
"""

import os
import sys
import time
import urllib.request
import ssl
from pathlib import Path

# SSL context for HTTPS
ssl_context = ssl.create_default_context()

OUTPUT_DIR = Path(__file__).parent / "bill-texts"

# Key bills from our analysis
PLASTIC_BILLS = [
    ("A", 1481),   # Microplastics testing (Karabinchak)
    ("A", 4367),   # Toxic Packaging Reduction Act (Collazos-Gill)
    ("A", 5338),   # REPEAL bag ban (Azzariti)
    ("A", 575),    # Recycled goods purchasing
    ("A", 2775),   # Recyclable marketing prohibition
    ("A", 4850),   # Single-use plastic ban for govt
    ("S", 1481),   # Senate companion - microplastics
    ("S", 4367),   # Senate companion - packaging
]

CLIMATE_BILLS = [
    ("A", 1461),   # Climate Mitigation Financing
    ("A", 2324),   # Hazard mitigation plans
    ("A", 2104),   # Flood mitigation
    ("A", 4281),   # Climate resiliency
    ("A", 3668),   # Coastal resilience
    ("A", 4095),   # Flood insurance
    ("S", 2104),   # Senate flood mitigation
    ("S", 2324),   # Senate hazard plans
]

def get_url(bill_type, bill_num, version="I1"):
    """Generate URL for bill PDF.
    
    URL pattern: https://pub.njleg.gov/Bills/2024/{Type}{Range}/{num}_{version}.PDF
    Range is based on bill number: 0-499 -> 0500, 500-999 -> 1000, etc.
    """
    # Calculate range folder
    range_start = ((bill_num - 1) // 500) * 500 + 1
    range_end = range_start + 499
    range_str = f"{bill_type}{range_end}"
    
    return f"https://pub.njleg.gov/Bills/2024/{range_str}/{bill_num}_{version}.PDF"


def download_bill(bill_type, bill_num, version="I1"):
    """Download a single bill PDF."""
    url = get_url(bill_type, bill_num, version)
    filename = f"{bill_type}{bill_num}_{version}.pdf"
    filepath = OUTPUT_DIR / filename
    
    if filepath.exists():
        print(f"  {filename} already exists, skipping")
        return True
    
    print(f"  Downloading {filename} from {url}")
    
    try:
        req = urllib.request.Request(url, headers={
            'User-Agent': 'Mozilla/5.0 (research project)'
        })
        with urllib.request.urlopen(req, context=ssl_context, timeout=30) as response:
            content = response.read()
            
        filepath.write_bytes(content)
        print(f"  ✓ Saved {filename} ({len(content)} bytes)")
        return True
        
    except urllib.error.HTTPError as e:
        print(f"  ✗ HTTP {e.code}: {url}")
        return False
    except Exception as e:
        print(f"  ✗ Error: {e}")
        return False


def download_bills(bills, category):
    """Download a list of bills."""
    print(f"\n{'='*60}")
    print(f"Downloading {category} bills")
    print(f"{'='*60}")
    
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    
    success = 0
    failed = 0
    
    for bill_type, bill_num in bills:
        # Try to get the introduced version first
        if download_bill(bill_type, bill_num, "I1"):
            success += 1
        else:
            failed += 1
        
        # Be nice to the server
        time.sleep(2)
    
    print(f"\nResults: {success} downloaded, {failed} failed")
    return success, failed


def main():
    args = sys.argv[1:]
    
    if not args or '--help' in args:
        print(__doc__)
        print("\nKey bills to download:")
        print(f"  Plastic: {len(PLASTIC_BILLS)} bills")
        print(f"  Climate: {len(CLIMATE_BILLS)} bills")
        return
    
    total_success = 0
    total_failed = 0
    
    if '--plastic' in args or '--all' in args:
        s, f = download_bills(PLASTIC_BILLS, "plastic-related")
        total_success += s
        total_failed += f
    
    if '--climate' in args or '--all' in args:
        s, f = download_bills(CLIMATE_BILLS, "climate-related")
        total_success += s
        total_failed += f
    
    # Handle individual bill requests
    for i, arg in enumerate(args):
        if arg == '--bill' and i + 1 < len(args):
            bill_str = args[i + 1].upper()
            bill_type = bill_str[0]
            bill_num = int(bill_str[1:])
            download_bill(bill_type, bill_num)
    
    print(f"\n{'='*60}")
    print(f"Total: {total_success} downloaded, {total_failed} failed")
    print(f"Bills saved to: {OUTPUT_DIR}")


if __name__ == "__main__":
    main()
