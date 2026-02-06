# NJ Legislature Hearing Analysis

Analysis of scientific testimony effectiveness in New Jersey legislative hearings.

## Hearings

| Date | Topic | Scientists | Status |
|------|-------|------------|--------|
| 2024-04-22 | Plastic Pollution | Dr. Phoebe Stapleton (Rutgers), Dr. Shanna Swan (Mt. Sinai) | ✅ Analyzed |
| 2024-08-01 | Climate Resiliency | Dr. Broccoli (Rutgers), Dr. Lin (Princeton), Dr. Herrington | 📋 Downloaded |
| 2024-03-11 | Clean Energy | Dr. Jesse Jenkins (Princeton) | 📋 Downloaded |
| 2024-03-07 | Climate Insurance | (Industry/policy focused) | 📋 Downloaded |

## Folder Structure

```
nj-2024-MM-DD-topic/
├── *.pdf           # Original hearing transcript (gitignored)
├── transcript.txt  # Extracted text
├── schema.sql      # Database schema (if analyzed)
├── ANALYSIS.md     # Findings report (if analyzed)
└── exports/        # CSV/TSV for spreadsheets (if analyzed)
```

## Methodology

See `nj-2024-04-22-plastic-pollution/ANALYSIS.md` for the full analytical framework:
- Scientific claim extraction with evidence grading
- Legislative item mapping
- Effectiveness scoring (rigor, relevance, specificity, engagement)

## Source

Transcripts from [NJ Legislature Public Hearings](https://www.njleg.state.nj.us/public-hearings)
