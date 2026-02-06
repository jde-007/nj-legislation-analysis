# NJ Legislation Analysis Process

**Version:** 1.0  
**Last Updated:** February 6, 2026

This document describes the complete process for analyzing NJ legislative hearings to understand effective scientific engagement in the legislative process.

---

## Overview

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  1. COLLECTION  │ ──▶ │  2. EXTRACTION  │ ──▶ │  3. CODING      │
│  Get transcript │     │  Parse content  │     │  Tag claims     │
└─────────────────┘     └─────────────────┘     └─────────────────┘
         │                                               │
         ▼                                               ▼
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  6. SYNTHESIS   │ ◀── │  5. BILL TRACE  │ ◀── │  4. EVIDENCE    │
│  Write analysis │     │  Link to bills  │     │  Grade quality  │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

---

## Phase 1: Collection

### 1.1 Source Identification

**Primary Source:** NJ Legislature Public Hearings Archive  
**URL:** https://www.njleg.state.nj.us/public-hearings  
**PDF Archive:** https://pub.njleg.state.nj.us/publications/public-hearings/

### 1.2 Download Transcript

1. Navigate to public hearings archive
2. Filter by year, committee, and topic
3. Download PDF transcript
4. Verify file is not corrupt (check file size, open in viewer)

### 1.3 Create Folder Structure

```bash
mkdir -p legislation/nj-YYYY-MM-DD-topic/
```

Naming convention: `nj-YYYY-MM-DD-topic` where topic is 2-4 word slug.

### 1.4 Document Source

Create `SOURCE.md` with:
- Original URL
- Download date
- Citation format
- Committee names

---

## Phase 2: Extraction

### 2.1 Text Extraction

Use PyMuPDF for PDF text extraction:

```python
import fitz  # PyMuPDF

def extract_transcript(pdf_path, output_path):
    doc = fitz.open(pdf_path)
    text = []
    for page_num, page in enumerate(doc, 1):
        text.append(f"--- PAGE {page_num} ---")
        text.append(page.get_text())
    
    with open(output_path, 'w') as f:
        f.write('\n'.join(text))
```

### 2.2 Quality Check

- Verify extraction worked (file > 10KB for most hearings)
- Check for OCR issues (scanned PDFs may extract as empty)
- Note any corrupted sections

### 2.3 Structure Identification

Identify in transcript:
- [ ] Committee names
- [ ] Date and location
- [ ] Member list
- [ ] Witness list (usually in table of contents)
- [ ] Stated purpose (usually in header)

---

## Phase 3: Coding

### 3.1 Witness Identification

For each witness, capture:
- Full name with credentials (Dr., Ph.D., etc.)
- Institutional affiliation
- Area of expertise
- Page numbers where they testify

### 3.2 Claim Extraction

For each scientific claim:
- The claim itself (factual assertion)
- Evidence type cited
- Source referenced (study, data set, etc.)
- Page number
- Verbatim quote (when impactful)

### 3.3 Evidence Typing

Classify evidence as:

| Type | Description | Example |
|------|-------------|---------|
| Peer-reviewed | Published in scientific journal | "A 2023 study in Nature..." |
| Government data | Official statistics or reports | "According to EPA data..." |
| Expert opinion | Professional judgment without citation | "In my 20 years of practice..." |
| Anecdotal | Individual case or story | "I had a patient who..." |
| Modeling | Simulation or projection | "Our models predict..." |

---

## Phase 4: Evidence Grading

### 4.1 Strength Categories

| Strength | Criteria |
|----------|----------|
| **Strong** | Peer-reviewed, replicated, consensus position, or authoritative government data |
| **Moderate** | Single peer-reviewed study, preliminary data, or emerging research |
| **Weak** | Anecdotal, opinion without citation, or contested claims |

### 4.2 Grading Rules

- Default to lower grade when uncertain
- "Strong" requires explicit citation to verifiable source
- Expert credentials alone don't make evidence "Strong"
- Government data is "Strong" if from official source

---

## Phase 5: Bill Tracing

### 5.1 Extract Bill References

Search transcript for bill patterns:
- `S####`, `S-####`, `S.####` (Senate bills)
- `A####`, `A-####`, `A.####` (Assembly bills)
- Named legislation references

### 5.2 Search Related Bills

If no bills mentioned in transcript:
1. Go to https://www.njleg.state.nj.us/bill-search
2. Search by keywords from hearing topic
3. Filter by session year
4. Filter by committee

### 5.3 Fetch Bill Text

For each relevant bill:
1. Get bill number and title
2. Download full bill text
3. Get committee statement (if available)
4. Get legislative history
5. Document current status

**Bill page URL pattern:**
```
https://www.njleg.state.nj.us/bill-search/2024/S####
```

### 5.4 Trace Testimony → Bill Language

Compare:
- Claims made in testimony vs. bill text
- Scientific evidence cited vs. findings sections
- Recommendations vs. enacted provisions

Document matches as:
- **Direct**: Testimony language appears nearly verbatim
- **Partial**: Concept included but modified
- **Inspired**: Bill addresses issue raised but differently

---

## Phase 6: Synthesis

### 6.1 Calculate Metrics

**Evidence Quality:**
```
Strong % = (Strong claims / Total claims) × 100
```

**Effectiveness Score:**
```
Score = (Rigor × 0.25) + (Relevance × 0.25) + (Specificity × 0.25) + (Engagement × 0.25)
```

Where each factor is rated 0-100:
- **Rigor**: Quality of evidence presented
- **Relevance**: NJ-specific data and local framing
- **Specificity**: Concrete policy recommendations
- **Engagement**: Legislator questions and follow-up

### 6.2 Write Analysis

Use `analysis_template.md` as base:
1. Fill in all sections
2. Ensure all quotes are verbatim with page refs
3. Verify all bill links work
4. Cross-reference with related hearings

### 6.3 Quality Assurance

Before finalizing:
- [ ] All quotes verified against transcript
- [ ] All page references correct
- [ ] All bill URLs tested
- [ ] SOURCE.md complete
- [ ] No claims without evidence classification

---

## Database Schema (Optional)

For structured analysis, use SQLite:

```sql
-- Core tables
CREATE TABLE hearings (id, date, title, committee, source_url, ...);
CREATE TABLE witnesses (id, hearing_id, name, affiliation, expertise, ...);
CREATE TABLE claims (id, witness_id, claim_text, evidence_type, strength, page_ref, ...);
CREATE TABLE bills (id, number, title, status, full_text_url, ...);
CREATE TABLE hearing_bills (hearing_id, bill_id, relationship, ...);
CREATE TABLE claim_bill_traces (claim_id, bill_id, match_type, bill_section, ...);
```

---

## File Structure

```
legislation/
├── SOURCES.md                    # Master source list
├── templates/
│   ├── ANALYSIS_PROCESS.md      # This file
│   └── analysis_template.md      # Template for analysis docs
├── nj-YYYY-MM-DD-topic/         # Per-hearing folder
│   ├── SOURCE.md                # Source documentation
│   ├── transcript.txt           # Extracted text
│   ├── ANALYSIS.md              # Completed analysis
│   ├── schema.sql               # Optional: DB schema
│   ├── seed.sql                 # Optional: DB seed data
│   └── *.pdf                    # Original PDF (gitignored)
└── unanalyzed/
    ├── CATALOG.md               # Priority guide
    └── *.txt                    # Extracted transcripts
```

---

## Appendix: Tools

### PDF Extraction

```bash
# Using PyMuPDF
python3 -c "
import fitz
import sys
doc = fitz.open(sys.argv[1])
for i, page in enumerate(doc, 1):
    print(f'--- PAGE {i} ---')
    print(page.get_text())
" input.pdf > transcript.txt
```

### Bill Pattern Search

```bash
# Find bill references in transcript
grep -oE '[SAsa][.-]?[0-9]{3,5}' transcript.txt | sort -u
```

### Commit Convention

```bash
git commit -m "Analyze [topic] hearing ([date])

- [N] scientific claims extracted
- [N] witnesses documented  
- [N] bills traced
- Effectiveness score: [X]%"
```

---

*Process developed through analysis of NJ legislative hearings, 2024-2026*
