# NJ Plastic Pollution Hearing Analysis

**Location:** `legislation/nj-2024-04-22-plastic-pollution`

**Naming Convention:** `[state]-[year]-[mm]-[dd]-[topic]`

---

Analysis of how scientific testimony influences legislative outcomes, using the **April 22, 2024 New Jersey Plastic Pollution Hearing** as a case study.

## Contents

| File | Description |
|------|-------------|
| `ANALYSIS.md` | Full report: "Effective Scientific Engagement in the Legislative Process" |
| `nj_legislation.db` | SQLite database with structured data |
| `transcript-full.txt` | Complete 67-page hearing transcript (text) |
| `plastic-pollution-hearing-2024-04-22.pdf` | Original source PDF |
| `exports/` | CSV/TSV files for Excel/Google Sheets |

## Key Findings

**Scientists Identified:**
- Dr. Phoebe Stapleton, Ph.D. (Rutgers) — micro/nanoplastics, fetal bioaccumulation
- Dr. Shanna H. Swan, Ph.D. (Mount Sinai) — Phthalate Syndrome, sperm decline research

**Quantitative Metrics:**
- 42 scientific claims extracted and coded
- 81% rated "strong" evidence (93.7% evidence quality score)
- Scientists received only 27% of Q&A despite 31% of testimony time
- Overall effectiveness score: 72.8/100

## Database Schema

```
hearings          - Hearing metadata
speakers          - 6 witness profiles (2 PhD scientists)
scientific_claims - 42 claims with page references
legislative_outcomes - 13 legislative items
committee_members - 8 legislators present
```

## Usage

```bash
# Query the database
sqlite3 nj_legislation.db "SELECT full_name, page_reference, claim_text FROM scientific_claims WHERE is_scientist = 1 LIMIT 5;"

# Import to Google Sheets
# Upload exports/*.csv files as separate sheets
```

## Source

- **Hearing Date:** April 22, 2024 (Earth Day)
- **Committees:** NJ Senate Environment & Energy + Assembly Environment, Natural Resources & Solid Waste
- **Transcript Source:** [NJ Legislature Public Hearings](https://pub.njleg.state.nj.us/publications/public-hearings/)
