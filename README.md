# NJ Legislation Scientific Engagement Analysis

Analysis of how scientific testimony influences legislative outcomes, using the **April 22, 2024 New Jersey Plastic Pollution Hearing** as a case study.

## What's Here

| File | Description |
|------|-------------|
| `ANALYSIS.md` | Full report: "Effective Scientific Engagement in the Legislative Process" |
| `nj_legislation.db` | SQLite database with structured data |
| `transcript-full.txt` | Complete 67-page hearing transcript (text) |
| `plastic-pollution-hearing-2024-04-22.pdf` | Original source PDF |
| `schema.sql` | Database schema |
| `seed.sql` | Speaker and hearing data |
| `claims.sql` | 42 evidence-graded scientific claims |
| `legislation.sql` | 13 legislative items (existing + proposed) |

## Key Findings

**Scientists Identified:**
- Dr. Phoebe Stapleton, Ph.D. (Rutgers) — micro/nanoplastics, fetal bioaccumulation
- Dr. Shanna H. Swan, Ph.D. (Mount Sinai) — Phthalate Syndrome, sperm decline research

**Most Effective Engagement Strategies:**
1. Local relevance (NJ-specific studies)
2. Human health narratives over environmental metrics
3. Research journey storytelling
4. Physical demonstrations/props
5. Policy precedent comparisons

**Database Contents:**
- 42 scientific claims (evidence-graded)
- 6 speaker profiles
- 13 legislative items
- 8 committee members

## Usage

```bash
# Query the database
sqlite3 nj_legislation.db "SELECT full_name, scientific_field FROM speakers WHERE is_scientist = 1;"

# Get claims by category
sqlite3 nj_legislation.db "SELECT claim_category, COUNT(*) FROM scientific_claims GROUP BY claim_category;"
```

## Source

- **Hearing Date:** April 22, 2024 (Earth Day)
- **Committees:** NJ Senate Environment & Energy + Assembly Environment, Natural Resources & Solid Waste
- **Location:** State House Annex, Trenton, NJ
- **Source:** [NJ Legislature Public Hearings](https://pub.njleg.state.nj.us/publications/public-hearings/)
