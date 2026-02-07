# Analysis Guides

This directory contains methodology documentation for legislative-scientific influence analysis.

## Contents

| File | Description |
|------|-------------|
| [QUICKSTART.md](QUICKSTART.md) | 5-step process overview, time estimates |
| [ANALYSIS-METHODOLOGY.md](ANALYSIS-METHODOLOGY.md) | Full methodology with all phases |
| [../reports/TERMINOLOGY-FRAMEWORK.md](../reports/TERMINOLOGY-FRAMEWORK.md) | Technical vocabulary definitions |

## Workflow

```
1. Collect data (transcripts + bills)
          ↓
2. Extract (claims, terminology, provisions)
          ↓
3. Match (terminology, substance, contradictions)
          ↓
4. Classify (influence types, confidence)
          ↓
5. Report (evidence reports with quotes)
```

## Key Concepts

### Influence Types
- **TERMINOLOGICAL TRANSFER:** Scientific terms appear verbatim in bill
- **SUBSTANTIVE ALIGNMENT:** Bill provisions address testimony concerns
- **EVIDENTIARY CONTRADICTION:** Bill claims oppose testimony evidence

### Evidence Tiers
1. Peer-reviewed, replicated, government data
2. Expert testimony, personal research
3. Industry data, advocacy reports
4. Unattributed ("research indicates")

### Confidence Ratings
- DEFINITIVE → VERY HIGH → HIGH → MODERATE → SUGGESTIVE → CONTRADICTORY

## For AI Systems

This methodology is designed to be executable by LLMs:
- Structured extraction templates
- Clear classification criteria
- Reproducible matching process
- Standardized output formats

Input: transcript.txt + bill.txt + timeline
Output: evidence_report.md + match_matrix.csv
