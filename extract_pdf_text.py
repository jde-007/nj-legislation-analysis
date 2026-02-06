#!/usr/bin/env python3
"""
Extract text from downloaded bill PDFs using PyMuPDF.
Creates .txt files alongside the PDFs.
"""

import sys
from pathlib import Path

try:
    import fitz  # PyMuPDF
except ImportError:
    print("PyMuPDF not installed. Run: pip install pymupdf")
    sys.exit(1)

BILL_DIR = Path(__file__).parent / "bill-texts"


def extract_text(pdf_path):
    """Extract text from a PDF file."""
    doc = fitz.open(pdf_path)
    text_parts = []
    
    for page_num, page in enumerate(doc, 1):
        text = page.get_text()
        if text.strip():
            text_parts.append(f"=== Page {page_num} ===\n{text}")
    
    doc.close()
    return "\n\n".join(text_parts)


def main():
    if not BILL_DIR.exists():
        print(f"Bill directory not found: {BILL_DIR}")
        sys.exit(1)
    
    pdfs = list(BILL_DIR.glob("*.pdf"))
    print(f"Found {len(pdfs)} PDF files in {BILL_DIR}")
    
    for pdf_path in sorted(pdfs):
        txt_path = pdf_path.with_suffix(".txt")
        
        if txt_path.exists():
            print(f"  {txt_path.name} already exists, skipping")
            continue
        
        print(f"  Extracting {pdf_path.name}...", end=" ")
        
        try:
            text = extract_text(pdf_path)
            txt_path.write_text(text)
            print(f"✓ ({len(text)} chars)")
        except Exception as e:
            print(f"✗ Error: {e}")
    
    # Summary
    txt_files = list(BILL_DIR.glob("*.txt"))
    print(f"\nTotal: {len(txt_files)} text files created")


if __name__ == "__main__":
    main()
