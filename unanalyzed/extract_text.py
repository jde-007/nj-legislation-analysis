#!/usr/bin/env python3
import fitz  # PyMuPDF
import sys
import os

def extract_pdf_text(pdf_path):
    """Extract text from PDF and save as .txt file"""
    try:
        doc = fitz.open(pdf_path)
        text = ""
        for page in doc:
            text += page.get_text()
        doc.close()
        
        # Create .txt filename
        txt_path = pdf_path.replace('.pdf', '.txt')
        
        with open(txt_path, 'w', encoding='utf-8') as f:
            f.write(text)
        
        return txt_path, len(text)
    except Exception as e:
        print(f"Error extracting text from {pdf_path}: {e}")
        return None, 0

if __name__ == "__main__":
    if len(sys.argv) > 1:
        pdf_files = sys.argv[1:]
    else:
        # Find all PDF files in current directory
        pdf_files = [f for f in os.listdir('.') if f.endswith('.pdf')]
    
    for pdf_file in pdf_files:
        if os.path.exists(pdf_file):
            txt_path, char_count = extract_pdf_text(pdf_file)
            if txt_path:
                print(f"Extracted {char_count} characters from {pdf_file} -> {txt_path}")
        else:
            print(f"File not found: {pdf_file}")