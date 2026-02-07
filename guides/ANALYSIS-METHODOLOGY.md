# Legislative-Scientific Influence Analysis: Methodology Guide

## Purpose

This guide provides a reproducible methodology for analyzing the influence of scientific testimony on legislative bill language. It is designed for use by human researchers or AI systems processing legislative data.

---

## Overview

The analysis answers three questions:
1. **Did testimony influence bill language?** (Influence Detection)
2. **Does bill language contradict testimony?** (Contradiction Detection)
3. **How confident can we be in these findings?** (Confidence Assessment)

---

## Phase 1: Data Collection

### 1.1 Acquire Hearing Transcripts

**Sources:**
- State legislature public hearing archives
- Office of Legislative Services publications
- Committee websites

**Required metadata:**
- Hearing date
- Committee(s) present
- Location
- Stated purpose/topic

**Preferred format:** Plain text extracted from PDF

**Quality check:** Verify page numbers match source PDF

### 1.2 Acquire Bill Texts

**Sources:**
- State legislature bill database
- Bulk data downloads (if available)
- Individual bill PDFs

**Required metadata:**
- Bill number (e.g., A4367, S1481)
- Sponsor(s) and co-sponsor(s)
- Introduction date
- Committee assignment
- Current status

**Preferred format:** Plain text with page/section markers

### 1.3 Establish Timeline

Create a chronological record:

```
[Hearing Date] → [Bill Introduction Date] → [Committee Actions] → [Current Status]
```

**Key metric:** Days between hearing and bill introduction

---

## Phase 2: Transcript Extraction

### 2.1 Identify Witnesses

Extract from transcript table of contents or opening remarks:

| Field | Example |
|-------|---------|
| Name | Dr. Shanna H. Swan |
| Title | Professor |
| Organization | Icahn School of Medicine, Mount Sinai |
| Expertise | Reproductive epidemiology, endocrine-disrupting chemicals |
| Page Start | 52 |
| Written Testimony | Yes/No |

### 2.2 Document Testimony Bill Positions

For each witness, identify which bills they addressed and their position:

| Bill # | Position | Summary |
|--------|----------|---------|
| A4367 | For | Strongly supports banning phthalates in packaging |
| S1481 | Neutral | Provided technical information only |
| A5338 | Against | Opposes repealing bag ban, cited evidence it works |

**Position Types:**
- **For:** Explicitly supports the bill
- **Against:** Explicitly opposes the bill
- **Neutral:** Provides information without taking position
- **Mixed:** Supports some provisions, opposes others

**Capture explicit statements:**
> "I urge this committee to pass A4367" → **For**
> "This bill would be a mistake" → **Against**
> "I'm here to provide scientific context" → **Neutral**

### 2.3 Extract Scientific Claims

For each witness, identify factual claims with:

**Claim structure:**
```
CLAIM: [Statement of fact or finding]
EVIDENCE TYPE: [Peer-reviewed | Government data | Personal research | Meta-analysis | Industry data]
SOURCE: [Specific citation if given]
PAGE: [Transcript page number]
VERBATIM QUOTE: [Exact text from transcript]
```

**Example:**
```
CLAIM: Worldwide sperm counts have declined 50% since 1970
EVIDENCE TYPE: Peer-reviewed (meta-analysis)
SOURCE: Published 2017, updated 2023
PAGE: 58
VERBATIM QUOTE: "sperm counts are declining... they've decreased -- since we started studying in about 1970 -- 50%, on average, worldwide"
```

### 2.3 Extract Technical Terminology

Create a terminology index from testimony:

| Term | Speaker | Context | Page |
|------|---------|---------|------|
| ortho-phthalates | Dr. Swan | Chemical class causing reproductive harm | 54 |
| endocrine disruptor | Dr. Swan | Chemicals affecting hormone signaling | 54 |
| microplastics | Dr. Stapleton | Particles <5mm in drinking water | 6 |

**Focus on:**
- Chemical names and classes
- Technical process names
- Regulatory category terms
- Quantitative thresholds
- Professional role categories

### 2.4 Extract Policy Recommendations

Identify explicit recommendations from witnesses:

```
RECOMMENDATION: [What action is proposed]
SPEAKER: [Who made it]
SPECIFICITY: [General | Specific bill reference | Regulatory action]
PAGE: [Transcript page]
```

### 2.5 Document Committee Structure

#### Primary Committee
| Field | Example |
|-------|---------|
| Name | Senate Environment and Energy Committee |
| Chamber | Senate / Assembly / Joint |
| Type | Standing / Joint / Taskforce / Council / Commission |
| Chair | Sen. Bob Smith |
| Vice Chair | Sen. Linda Greenstein |

#### Joint Committees, Taskforces, Councils, Commissions
If multiple bodies are involved, document each:

| Body Name | Type | Role in Hearing |
|-----------|------|-----------------|
| NJ Climate Change Resource Center | Council | Co-host |
| Coastal Resilience Task Force | Taskforce | Presenting findings |

### 2.6 Document All People Present

#### Committee Members
| Name | Role | Party | District | Eagleton Fellow? |
|------|------|-------|----------|------------------|
| Sen. Bob Smith | Chair | D | 17 | No |
| Sen. Michael Testa | Member | R | 1 | No |

#### Also Present (Staff, Observers, Advisors)
| Name | Title/Affiliation | Role | Eagleton Fellow? |
|------|-------------------|------|------------------|
| Dr. Jane Doe | DEP Science Advisor | Staff | Yes (2022-2023) |

**Eagleton Science Fellow Cross-Reference:**
Check all attendees against the Eagleton Science Fellows database (`database/exports/eagleton_fellows.csv`). Flag any matches with fellowship year.

### 2.7 Retain Committee Notice/Agenda

**Required:** Save the official committee notice or hearing agenda.
- Store in hearing folder as `committee-notice.pdf` or `agenda.pdf`
- Path recorded in database: `committee_notice_path`
- Agenda often lists bills to be discussed and scheduled actions

### 2.8 Document Bills on Agenda

Extract from committee notice or hearing record:

| Bill # | Title | Scheduled Action | Sponsor |
|--------|-------|------------------|---------|
| A4367 | Toxic Packaging Reduction Act | First Reading | Collazos-Gill |
| S1481 | Microplastics Testing | Vote | Smith |

**Scheduled Action Types:**
- Discussion / First Reading
- Testimony
- Vote
- Amendment consideration
- Substitution

### 2.9 Document Bill Actions Taken

Record what actually happened to each bill at the hearing:

| Bill # | Action | Result | Vote (Y-N-A) | Notes |
|--------|--------|--------|--------------|-------|
| S1481 | Vote | Passed | 5-2-1 | Amended before vote |
| A4367 | Held | — | — | Deferred to next session |

**Action Types:**
- Vote (passed/failed with counts)
- Amendment (adopted/rejected)
- Substitution (bill replaced)
- Held (deferred)
- Released (from committee)
- Tabled

---

## Phase 3: Bill Extraction

### 3.1 Parse Bill Structure

Identify key sections:

| Section | Content |
|---------|---------|
| Synopsis | One-paragraph summary |
| Definitions | Section 1 typically |
| Substantive provisions | Sections 2-N |
| Enforcement/penalties | Often near end |
| Statement | Sponsor's explanatory statement |

### 3.2 Extract Regulated Substances/Actions

Create an index of what the bill regulates:

```
SUBSTANCE/ACTION: ortho-phthalates
SECTION: 4(d)(2)
REGULATION TYPE: Prohibition
EFFECTIVE DATE: 2 years after enactment
```

### 3.3 Extract Definitions

Document how the bill defines key terms:

```
TERM: endocrine disruptor
DEFINITION: [Full text from bill]
SECTION: 1
```

### 3.4 Extract Evidence Claims in Bill Statement

If the bill's statement section cites evidence:

```
CLAIM: [What the statement asserts]
CITATION: [Specific source if given, or "unattributed"]
TIER: [1-4 per evidence quality framework]
```

---

## Phase 4: Matching Analysis

### 4.1 Terminology Matching

**Process:**
1. Take each term from testimony terminology index
2. Search bill text for exact or near-exact matches
3. Document matches with section references

**Match types:**
- **EXACT:** Identical term (e.g., "ortho-phthalates" → "ortho-phthalates")
- **NEAR:** Same concept, minor variation (e.g., "endocrine-disrupting chemicals" → "endocrine disruptor")
- **CONCEPTUAL:** Same meaning, different words (e.g., "make plastic soft" → "plasticizer")

### 4.2 Substantive Matching

**Process:**
1. Take each policy recommendation from testimony
2. Compare to bill provisions
3. Assess alignment level

**Alignment levels:**
- **DIRECT:** Bill implements recommendation as stated
- **PARTIAL:** Bill addresses same concern differently
- **TANGENTIAL:** Bill touches related issue
- **NONE:** No connection found

### 4.3 Contradiction Detection

**Process:**
1. Take each claim from testimony
2. Search bill statement for contrary claims
3. Document contradictions with both quotes

**Contradiction types:**
- **FACTUAL:** Bill asserts opposite fact
- **POLICY:** Bill takes opposite policy position
- **OMISSION:** Bill ignores key testimony findings

### 4.4 Sponsor-Witness Connection

**Check:**
1. Was bill sponsor present at hearing? (Check attendance list)
2. Did sponsor ask questions of relevant witnesses?
3. What was temporal gap between hearing and bill introduction?

---

## Phase 5: Classification

### 5.1 Assign Influence Types

For each testimony-bill connection, classify:

| Type | Criteria |
|------|----------|
| TERMINOLOGICAL TRANSFER | Exact/near term match found |
| SUBSTANTIVE ALIGNMENT | Policy recommendation → bill provision |
| TEMPORAL CAUSATION | Bill introduced within 90 days of hearing |
| SPONSOR PRESENCE | Sponsor attended hearing |
| EVIDENTIARY CONTRADICTION | Bill contradicts testimony claims |
| SOURCE ASYMMETRY | Bill uses lower-tier evidence than testimony |

### 5.2 Assign Confidence Rating

| Rating | Required Evidence |
|--------|-------------------|
| DEFINITIVE | Terminological transfer + sponsor presence + temporal causation |
| VERY HIGH | Terminological transfer + substantive alignment |
| HIGH | Substantive alignment + temporal causation |
| MODERATE | Substantive alignment OR (temporal causation + sponsor presence) |
| SUGGESTIVE | Thematic similarity only |
| CONTRADICTORY | Documented factual opposition |

---

## Phase 6: Report Generation

### 6.1 Evidence Report Structure

For each testimony-bill connection:

```markdown
# Evidence Report: [Bill Number]

## Bill Information
- Number, title, sponsor, date, status

## Influence Classification
- Types detected
- Confidence rating

## Evidence Exhibits

### Exhibit N: [Topic]

#### Testimony
> [Verbatim quote]
> — [Speaker], Page [N]

#### Bill Language
> [Verbatim bill text]
> — Section [X], Page [N]

#### Analysis
[Explanation of connection]

## Timeline
[Hearing date] → [Bill introduction] → [Gap in days]

## Sponsor Presence
[Documentation of sponsor at hearing]

## Conclusion
[Summary of influence finding]
```

### 6.2 Contradiction Report Structure

```markdown
# Contradiction Report: [Bill Number]

## Bill Claims vs. Testimony Evidence

### Testimony Position
> [Quote from hearing]
> — [Speaker], Page [N]
> Evidence Tier: [1-4]

### Bill Position
> [Quote from bill statement]
> — [Section]
> Evidence Tier: [1-4]

### Analysis
- Contradiction type: [FACTUAL | POLICY | OMISSION]
- Source asymmetry: [Yes/No with explanation]
- Sponsor presence at hearing: [Yes/No]
```

---

## Phase 7: Quality Assurance

### 7.1 Verification Checklist

- [ ] All quotes verified against source transcript
- [ ] Page numbers confirmed
- [ ] Bill section references confirmed
- [ ] Sponsor attendance verified in transcript
- [ ] Timeline dates verified
- [ ] Terminology matches are exact (not paraphrased)

### 7.2 Bias Mitigation

- Document ALL testimony on topic, not just quotes supporting findings
- Include contradicting witness testimony if present
- Note uncertainty in classifications
- Distinguish between "likely influenced" and "definitely influenced"

### 7.3 Limitations Statement

Every report should acknowledge:
- Correlation ≠ causation
- Multiple pathways may exist (lobbyists, staff research, etc.)
- Bill language may predate hearing (check for prior versions)
- Sponsors may disagree with testimony they heard

---

## Appendix A: Quick Reference Checklist

### Before Starting
- [ ] Hearing transcript obtained (text format)
- [ ] Committee notice/agenda obtained and saved
- [ ] Relevant bills identified (from agenda + discussed)
- [ ] Bill texts obtained (text format)
- [ ] Timeline established

### Committee & Attendance
- [ ] Primary committee documented (name, chamber, type)
- [ ] Joint committees/taskforces/councils/commissions documented
- [ ] All committee members present listed with roles
- [ ] All other attendees listed (staff, observers)
- [ ] Cross-referenced against Eagleton Fellows database
- [ ] Committee notice retained in hearing folder

### Bills on Agenda
- [ ] All bills on agenda listed with scheduled actions
- [ ] Actual actions taken documented (votes, amendments, held)
- [ ] Vote counts recorded where applicable

### Extraction
- [ ] Witnesses catalogued with credentials
- [ ] Testimony-bill positions documented (for/against/neutral/mixed per bill)
- [ ] Scientific claims extracted with evidence types
- [ ] Technical terminology indexed
- [ ] Policy recommendations documented

### Bill Analysis
- [ ] Bill structure parsed
- [ ] Definitions extracted
- [ ] Regulated substances/actions indexed
- [ ] Statement claims documented with citation quality

### Matching
- [ ] Terminology matching complete
- [ ] Substantive alignment assessed
- [ ] Contradictions identified
- [ ] Sponsor-witness connections documented

### Classification
- [ ] Influence types assigned
- [ ] Confidence ratings justified
- [ ] Source asymmetry evaluated

### Reporting
- [ ] Verbatim quotes included
- [ ] Page references provided
- [ ] Analysis clearly separated from evidence
- [ ] Confidence rating explained

---

## Appendix B: Common Pitfalls

### 1. Quote Accuracy
**Wrong:** Paraphrasing testimony
**Right:** Verbatim quotes with "..." for omissions

### 2. Confirmation Bias
**Wrong:** Only extracting testimony that supports influence finding
**Right:** Documenting full range of testimony on topic

### 3. Temporal Assumptions
**Wrong:** Assuming post-hearing bill was caused by hearing
**Right:** Checking for pre-hearing bill versions, noting limitation

### 4. Terminology Inflation
**Wrong:** Claiming "conceptual match" is terminological transfer
**Right:** Reserving "terminological transfer" for exact/near-exact matches

### 5. Ignoring Contradictions
**Wrong:** Only reporting influence, not contradictions
**Right:** Full analysis including bills that oppose testimony

---

## Appendix C: Scaling Considerations

### For Multiple Hearings
- Maintain consistent witness ID format
- Track cross-hearing witness appearances
- Build cumulative terminology index

### For Multiple Bills
- Create bill-to-hearing linkage table
- Track bills with multiple hearing connections
- Note bill amendments that change alignment

### For Automated Processing
- Standardize input formats (JSON, CSV)
- Create term similarity thresholds for near-matches
- Build validation dataset from manual analysis

---

## Appendix D: Output Artifacts

A complete analysis should produce:

1. **Witness Catalog** (CSV/JSON)
2. **Claims Database** (structured, with evidence grading)
3. **Terminology Index** (searchable)
4. **Bill Index** (with section parsing)
5. **Match Matrix** (testimony × bill provisions)
6. **Evidence Reports** (per-connection, Markdown)
7. **Summary Report** (cross-connection synthesis)

---

*Methodology version: 2.0*
*Developed: February 6, 2026*
*Updated: February 7, 2026*
*Based on analysis of NJ legislative hearings, 2024-2025*

## Changelog

### v2.0 (2026-02-07)
- Added committee structure documentation (joint committees, taskforces, councils, commissions)
- Added bill agenda tracking with scheduled vs actual actions
- Added testimony-bill position tracking (for/against/neutral/mixed)
- Added Eagleton Science Fellow cross-referencing
- Added committee notice retention requirement
- Added all-people-present tracking (not just committee members)
