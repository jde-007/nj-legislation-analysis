# NJ Legislative Science Impact Analysis

## Mission

**Demonstrate the impact of the Eagleton Science Fellowship on evidence-based policy making in New Jersey.**

This project analyzes how scientific testimony—particularly from Eagleton Science Fellows—influences legislative outcomes. We define, measure, and quantify what it means for legislation to be "evidence-based" and track the degree to which NJ legislative activity incorporates scientific evidence.

## The Big Question

> **For each hearing over time, how much scientific evidence was presented to legislators and committee members? How did this evidence impact the bills that the hearings influenced? If there was a Science Fellow as part of the committee, how does that impact the amount or quality of scientific evidence being presented?**

We want to surface whether legislation was impacted by evidence-based input from Science Fellows.

### Unpacking the Question

| Question | What We Measure | How |
|----------|-----------------|-----|
| How much evidence per hearing? | Claims count, evidence tier distribution, scientist witnesses | Per-hearing metrics |
| How did evidence impact bills? | Terminology transfer, EBLS scores, alignment with testimony | Bill-hearing cross-reference |
| Does Fellow presence change evidence quality? | Compare hearings/bills WITH vs WITHOUT Fellow involvement | Comparative analysis |

### Key Comparisons

1. **Hearings WITH Science Fellow** vs **Hearings WITHOUT**
   - Average # of scientific claims
   - Evidence quality distribution (% Tier 1-2)
   - Subsequent bill EBLS scores

2. **Bills influenced by Fellow testimony** vs **Bills without Fellow involvement**
   - Evidence-Based Legislation Score
   - Contradiction rate
   - Terminology transfer from testimony

3. **Committees WITH Fellow staff** vs **Committees WITHOUT**
   - Volume of scientist testimony invited
   - Bill passage rates for evidence-aligned legislation
   - Evidence quality trends over time

## Research Questions

1. **What makes legislation "evidence-based"?**
   - Define measurable criteria for evidence quality in legislation
   - Create a scoring framework applicable across bills and hearings

2. **How do Eagleton Science Fellows impact the legislative process?**
   - Track Fellow participation in hearings, committees, and policy development
   - Measure terminology transfer from Fellow testimony to bill language
   - Compare evidence quality in legislation with vs. without Fellow involvement

3. **What is the current state of evidence-based policy making in NJ?**
   - Baseline measurements across policy domains (environment, health, energy)
   - Trend analysis over time
   - Comparison of committee effectiveness

## The Eagleton Science Fellowship

The [Eagleton Science and Politics Fellowship](https://eagleton.rutgers.edu/eagleton-science-and-politics-program/) places PhD-level scientists in NJ state government for one-year appointments. Fellows work in:

- **Legislative Track**: Senate/Assembly offices
- **Executive Track**: State departments (DEP, DOH, DOE, etc.)
- **Climate Action Track**: Board of Public Utilities, climate-focused agencies

Since its inception, 37+ fellows have served in positions across NJ government, bringing scientific expertise to policy development.

## Evidence-Based Legislation Framework

See [framework/EVIDENCE-BASED-FRAMEWORK.md](framework/EVIDENCE-BASED-FRAMEWORK.md) for full definitions.

### Quick Reference: Evidence Quality Tiers

| Tier | Type | Description | Score |
|------|------|-------------|-------|
| 1 | Peer-reviewed | Published, replicated research | 4 |
| 2 | Government/Institutional | Official data, agency reports | 3 |
| 3 | Expert testimony | Professional opinion without citation | 2 |
| 4 | Anecdotal/Unattributed | "Studies show...", personal experience | 1 |
| 0 | No evidence | Assertion without support | 0 |

### Evidence-Based Legislation Score (EBLS)

A composite metric (0-100) measuring:
- **Evidence Quality** (40%): Average tier of evidence cited
- **Source Diversity** (20%): Range of evidence types
- **Scientist Engagement** (20%): Expert testimony incorporated
- **NJ Specificity** (10%): Local data vs. national generalizations
- **Contradiction Avoidance** (10%): Absence of claims contradicting testimony

## Project Structure

```
legislation/
├── README.md                    # This file
├── framework/                   # Evidence-based legislation framework
│   └── EVIDENCE-BASED-FRAMEWORK.md
├── database/                    # SQLite database + exports
│   ├── schema_v2.sql           # Full schema
│   ├── legislation.db          # Database (rebuild from .sql files)
│   └── exports/                # CSV exports
├── guides/                      # Methodology documentation
│   └── ANALYSIS-METHODOLOGY.md
├── templates/                   # Analysis templates
│   └── analysis_template.md
├── nj-YYYY-MM-DD-topic/        # Per-hearing analysis folders
├── bill-texts/                  # Extracted bill texts + PDFs
├── reports/                     # Cross-cutting analysis reports
└── unanalyzed/                  # Hearing PDFs awaiting analysis
```

## Key Metrics We Track

### Per Hearing
- Total witnesses / scientist witnesses
- Eagleton Fellows present (as witnesses, staff, or observers)
- Evidence quality distribution (% Tier 1-2 vs Tier 3-4)
- Bills on agenda and actions taken
- Terminology transfers to subsequent legislation

### Per Bill
- Evidence-Based Legislation Score (EBLS)
- Source quality of claims in bill statement
- Alignment with expert testimony
- Contradictions with scientific evidence
- Eagleton Fellow involvement in drafting/testimony

### Per Scientist/Fellow
- Hearings attended
- Claims made with evidence tier distribution
- Terms adopted in legislation
- Influence score

## Current Status

### Analyzed Hearings
| Date | Topic | Scientists | EBLS | Eagleton Fellows |
|------|-------|------------|------|------------------|
| 2024-04-22 | Plastic Pollution | 3 | 72.8 | TBD |
| 2024-08-01 | Climate Resiliency | 4 | 78.5 | TBD |

### Pending Analysis
30+ hearing transcripts from 2000-2024 in `unanalyzed/`

## Getting Started

```bash
# Rebuild the database
cd database
sqlite3 legislation.db < schema_v2.sql
sqlite3 legislation.db < seed_analyzed.sql
sqlite3 legislation.db < seed_eagleton_fellows.sql

# Query the data
python3 query.py scientists
python3 query.py effectiveness
python3 query.py sql "SELECT * FROM people WHERE is_eagleton_fellow = 1"
```

## Contributing

Analysis follows the methodology in `guides/ANALYSIS-METHODOLOGY.md`. Use `templates/analysis_template.md` for new hearing analyses.

## Outputs

This research will produce:
1. **Evidence-Based Legislation Framework** — Reusable definitions and metrics
2. **Eagleton Impact Report** — Quantified Fellow influence on NJ policy
3. **Legislative Evidence Quality Baseline** — Current state of evidence use in NJ
4. **Best Practices Guide** — How scientists can effectively engage with legislators

---

*Repository: [jde-007/nj-legislation-analysis](https://github.com/jde-007/nj-legislation-analysis)*
*Contact: Eagleton Institute of Politics, Rutgers University*
