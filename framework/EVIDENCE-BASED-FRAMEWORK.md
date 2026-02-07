# Evidence-Based Legislation Framework

## Purpose

This framework provides **definitions and quantification methods** for measuring how "evidence-based" a piece of legislation is. It enables:

1. Objective comparison across bills
2. Tracking improvement over time
3. Measuring the impact of scientific engagement on policy quality
4. Identifying gaps where evidence is needed or ignored

---

## Part 1: Defining Evidence-Based Legislation

### What is Evidence-Based Legislation?

**Evidence-based legislation** is lawmaking that:

1. **Cites verifiable evidence** for claims made in bill statements and findings
2. **Incorporates expert testimony** from qualified scientists and professionals
3. **Aligns with scientific consensus** on empirical questions
4. **Avoids contradicting** established evidence without justification
5. **Uses appropriate evidence** for the policy context (local data for local problems)

### What Evidence-Based Legislation is NOT

- **Advocacy dressed as science**: Cherry-picking studies to support predetermined conclusions
- **Appeal to authority**: "Experts say..." without specific citations
- **Anecdote as data**: Personal stories as the primary basis for policy
- **Outdated evidence**: Relying on superseded research
- **Misrepresented evidence**: Citing studies for conclusions they don't support

---

## Part 2: Evidence Quality Tiers

### Tier Definitions

| Tier | Name | Definition | Examples |
|------|------|------------|----------|
| **1** | Peer-Reviewed Research | Published in peer-reviewed journals, ideally replicated | "A 2023 meta-analysis in The Lancet found..." |
| **2** | Government/Institutional Data | Official statistics, agency reports, institutional research | "EPA data shows...", "NJ DEP monitoring indicates..." |
| **3** | Expert Testimony | Professional opinion from qualified experts, without specific citation | "Dr. Smith, a toxicologist at Rutgers, testified that..." |
| **4** | Anecdotal/Unattributed | Personal experience, "research shows" without citation | "Residents have reported...", "Studies indicate..." |
| **0** | No Evidence | Assertions without any supporting evidence | "This bill will reduce pollution" (no data cited) |

### Scoring

- Tier 1: 4 points
- Tier 2: 3 points
- Tier 3: 2 points
- Tier 4: 1 point
- Tier 0: 0 points

---

## Part 3: Evidence-Based Legislation Score (EBLS)

### Overview

The **Evidence-Based Legislation Score (EBLS)** is a composite metric from 0-100 that quantifies how evidence-based a piece of legislation is.

### Components

| Component | Weight | Description |
|-----------|--------|-------------|
| Evidence Quality (EQ) | 40% | Average tier score of evidence cited |
| Source Diversity (SD) | 20% | Range of evidence types used |
| Scientist Engagement (SE) | 20% | Expert testimony incorporated |
| NJ Specificity (NJS) | 10% | Use of NJ-specific data |
| Contradiction Avoidance (CA) | 10% | Absence of claims contradicting expert testimony |

### Calculation

```
EBLS = (EQ × 0.40) + (SD × 0.20) + (SE × 0.20) + (NJS × 0.10) + (CA × 0.10)
```

Each component is normalized to 0-100 before weighting.

---

## Part 4: Component Definitions

### 4.1 Evidence Quality (EQ)

**What it measures**: The average quality of evidence cited in the bill.

**Calculation**:
```
EQ = (Sum of tier scores for all claims / Maximum possible score) × 100
```

**Example**:
- Bill makes 5 claims
- Tiers: 1, 2, 2, 3, 4
- Sum: 4 + 3 + 3 + 2 + 1 = 13
- Max possible: 5 × 4 = 20
- EQ = (13/20) × 100 = **65**

### 4.2 Source Diversity (SD)

**What it measures**: Whether the bill draws on multiple types of evidence.

**Calculation**:
```
SD = (Number of distinct evidence types used / 4) × 100
```

**Evidence types**:
1. Peer-reviewed research
2. Government data
3. Expert testimony
4. Stakeholder input

**Example**:
- Bill cites peer-reviewed research and government data
- Types used: 2
- SD = (2/4) × 100 = **50**

### 4.3 Scientist Engagement (SE)

**What it measures**: Whether qualified scientists contributed to the bill's development.

**Scoring rubric**:

| Criteria | Points |
|----------|--------|
| Scientist testified at related hearing | +25 |
| Scientist testimony cited in bill | +25 |
| Eagleton Fellow involved in drafting/review | +25 |
| Bill sponsor attended hearing with scientist testimony | +15 |
| Technical definitions align with scientific usage | +10 |

**Maximum**: 100 points

### 4.4 NJ Specificity (NJS)

**What it measures**: Whether the bill uses NJ-specific evidence rather than only national/general data.

**Calculation**:
```
NJS = (Claims with NJ-specific evidence / Total claims) × 100
```

**Why it matters**: Local data is more persuasive to legislators and more relevant to policy design.

**Example**:
- 10 claims in bill
- 3 cite NJ-specific data (e.g., "NJ DEP found...", "In Trenton,...")
- NJS = (3/10) × 100 = **30**

### 4.5 Contradiction Avoidance (CA)

**What it measures**: Whether the bill avoids contradicting scientific testimony without justification.

**Scoring**:
```
CA = 100 - (Number of contradictions × 20)
```

**Minimum**: 0

**What counts as a contradiction**:
- Bill statement asserts opposite of expert testimony
- Bill cites lower-tier evidence to dispute higher-tier evidence
- Bill ignores key findings from related hearings

**Example**:
- Bill contradicts 2 pieces of expert testimony
- CA = 100 - (2 × 20) = **60**

---

## Part 5: Classifying Bills

### EBLS Ranges

| Score | Classification | Description |
|-------|---------------|-------------|
| 80-100 | **Exemplary** | Strong evidence basis, scientist engagement, no contradictions |
| 60-79 | **Good** | Solid evidence, some gaps in engagement or specificity |
| 40-59 | **Moderate** | Mixed evidence quality, limited scientist input |
| 20-39 | **Weak** | Mostly anecdotal, minimal expert engagement |
| 0-19 | **Poor** | No meaningful evidence basis |

### Red Flags

Bills that should be flagged regardless of score:
- **Contradicts scientific consensus** on empirical questions
- **Cites retracted or discredited research**
- **Misrepresents cited sources**
- **Uses Tier 4 evidence to override Tier 1-2 evidence**

---

## Part 6: Measuring Legislative Activity

### Hearing-Level Metrics

For each committee hearing:

| Metric | Definition |
|--------|------------|
| Scientist Participation Rate | % of witnesses who are scientists |
| Eagleton Fellow Presence | # of Fellows present (any role) |
| Evidence Quality Distribution | % of claims at each tier |
| Bill Actions Aligned with Testimony | # of votes matching expert recommendations |
| Terminology Transfer Rate | # of terms from testimony appearing in subsequent bills |

### Committee-Level Metrics

Aggregate across all hearings for a committee:

| Metric | Definition |
|--------|------------|
| Average EBLS of Bills Passed | Mean score of bills voted out |
| Scientist Testimony Volume | Total scientist witnesses per session |
| Evidence Improvement Trend | Change in average evidence quality over time |
| Eagleton Fellow Engagement | Total Fellow appearances |

### Session-Level Metrics

Aggregate across all committees for a legislative session:

| Metric | Definition |
|--------|------------|
| Evidence-Based Legislation Rate | % of bills with EBLS ≥ 60 |
| Scientific Contradiction Rate | % of bills contradicting expert testimony |
| Eagleton Impact Score | Composite of Fellow influence metrics |

---

## Part 7: The Core Analysis — Fellow Impact on Evidence Quality

### The Central Question

> For each hearing over time, how much scientific evidence was presented? How did this evidence impact bills? If there was a Science Fellow involved, how does that change the amount or quality of evidence?

### Comparative Analysis Design

We measure Fellow impact by comparing outcomes **with** vs **without** Fellow involvement.

#### Comparison Groups

| Group A (With Fellow) | Group B (Without Fellow) |
|----------------------|--------------------------|
| Hearings where Fellow testified | Hearings with no Fellow testimony |
| Hearings where Fellow on committee staff | Hearings without Fellow staff |
| Bills with Fellow involvement in drafting | Bills with no Fellow involvement |
| Committees with Fellow placement | Committees without Fellow placement |

#### Metrics to Compare

| Metric | Group A (With) | Group B (Without) | Δ (Difference) |
|--------|---------------|-------------------|----------------|
| Avg claims per hearing | ? | ? | ? |
| % Tier 1-2 evidence | ? | ? | ? |
| Avg EBLS of related bills | ? | ? | ? |
| Contradiction rate | ? | ? | ? |
| Terminology transfer count | ? | ? | ? |
| NJ-specific evidence % | ? | ? | ? |

### Time Series Analysis

Track metrics **over time** to identify:
1. **Trends**: Is evidence quality improving?
2. **Inflection points**: Do Fellow placements correlate with quality improvements?
3. **Committee differences**: Which committees show most Fellow impact?

#### Visualization Plan

```
Evidence Quality Over Time
Y-axis: Average Evidence Tier (1-4)
X-axis: Year (2015-2026)
Series: 
  - All hearings (baseline)
  - Hearings with Fellow involvement
  - Hearings without Fellow involvement
```

```
Fellow Impact by Committee
Y-axis: EBLS Score (0-100)
X-axis: Committee
Bars:
  - Bills with Fellow involvement (blue)
  - Bills without Fellow involvement (gray)
```

### Causation Considerations

Correlation ≠ causation. Fellows might be placed where evidence culture already exists. To strengthen causal claims:

1. **Before/After**: Compare same committee before and after Fellow placement
2. **Matched Pairs**: Compare similar hearings differing only in Fellow presence
3. **Dose-Response**: Do more Fellow interactions = better scores?
4. **Mechanism Tracing**: Document specific terminology transfers from Fellow testimony

## Part 8: Eagleton Impact Metrics

### Fellow-Specific Metrics

For each Eagleton Science Fellow:

| Metric | Definition |
|--------|------------|
| Hearings Attended | Count during fellowship year |
| Testimony Given | Count of formal testimony |
| Claims Made | Total claims with evidence tier |
| Evidence Quality | Average tier of Fellow's claims |
| Terms Adopted | Count of terminology transfers |
| Bills Influenced | Count of bills with Fellow involvement |

### Program-Wide Metrics

| Metric | Definition |
|--------|------------|
| Fellow Coverage | % of environment/health/energy hearings with Fellow present |
| Influence Reach | # of bills with traceable Fellow impact |
| Evidence Uplift | EBLS difference: bills with Fellow involvement vs. without |
| Placement Effectiveness | Impact metrics by placement type (legislative vs. executive) |

---

## Part 8: Data Collection Requirements

### Per Bill
- [ ] All claims extracted from bill statement/findings
- [ ] Each claim assigned evidence tier
- [ ] Sources identified and categorized
- [ ] Scientist engagement documented
- [ ] Contradictions with testimony identified

### Per Hearing
- [ ] All witnesses catalogued with credentials
- [ ] Eagleton Fellows flagged
- [ ] All claims extracted with evidence
- [ ] Bills on agenda and actions recorded
- [ ] Testimony-bill positions documented

### Per Session
- [ ] All relevant bills indexed
- [ ] All relevant hearings analyzed
- [ ] Cross-references completed
- [ ] Aggregate metrics calculated

---

## Part 9: Limitations

### What This Framework Cannot Measure

1. **Legislative intent**: We measure evidence cited, not whether legislators believed it
2. **Political feasibility**: High-EBLS bills may still fail for political reasons
3. **Implementation quality**: Evidence-based legislation may be poorly implemented
4. **Completeness**: We can only analyze publicly available documents
5. **Causation**: Correlation between Fellow presence and bill quality ≠ causation

### Potential Biases

- **Availability bias**: Well-documented hearings may score higher
- **Topic bias**: Some policy areas have more published research
- **Hindsight bias**: Knowing outcomes may influence interpretation

---

## Part 10: Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-02-07 | Initial framework |

---

*This framework is designed to be applied consistently across NJ legislative analysis. Updates should be documented and versioned.*
