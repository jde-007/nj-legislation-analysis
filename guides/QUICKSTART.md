# Quick Start: Legislative-Scientific Influence Analysis

## What You Need

1. **Hearing transcript** (text format, with page numbers)
2. **Related bill text(s)** (text format, with section numbers)
3. **Timeline** (hearing date, bill introduction dates)

---

## 5-Step Process

### Step 1: Extract from Transcript (30-60 min per hearing)

**A. List witnesses with credentials**
```
Dr. Shanna Swan | Mount Sinai | Reproductive epidemiology | Page 52
```

**B. Pull verbatim quotes for key claims**
```
"They called this -- they named this -- the Phthalate Syndrome."
— Dr. Swan, Page 56
```

**C. Build terminology list**
```
ortho-phthalates | endocrine disruptor | microplastics | nanoplastics
```

**D. Note who was present** (sponsors of related bills?)

---

### Step 2: Extract from Bills (15-30 min per bill)

**A. Parse definitions section**
```
"Toxic substance" means... "endocrine disruptor"
— Section 1, Page 3
```

**B. List regulated items**
```
(2) ortho-phthalates;
(3) bisphenols;
```

**C. Check statement section for evidence claims**
```
"Research indicates..." [Tier 4 - unattributed]
```

---

### Step 3: Match (15-30 min)

**Compare terminology:**

| Testimony Term | Bill Term | Match Type |
|----------------|-----------|------------|
| phthalates | ortho-phthalates | EXACT |
| endocrine-disrupting chemicals | endocrine disruptor | NEAR |

**Check for contradictions:**

| Testimony Claim | Bill Claim | Conflict? |
|-----------------|------------|-----------|
| "bag ban worked" | "increased waste" | YES |

---

### Step 4: Classify

**Influence indicators:**
- [ ] TERMINOLOGICAL TRANSFER — exact terms appear
- [ ] SUBSTANTIVE ALIGNMENT — recommendations → provisions
- [ ] SPONSOR PRESENCE — sponsor was at hearing
- [ ] TEMPORAL CAUSATION — bill followed hearing (<90 days)

**Contradiction indicators:**
- [ ] EVIDENTIARY CONTRADICTION — opposite claims
- [ ] SOURCE ASYMMETRY — bill uses weaker evidence

**Confidence:**
- DEFINITIVE = terminology + sponsor + timing
- VERY HIGH = terminology + alignment
- CONTRADICTORY = documented opposition

---

### Step 5: Report

**Template:**
```markdown
## [Bill Number]: [Title]

### Influence Finding
[Type] | [Confidence]

### Key Evidence

**Testimony:**
> [Quote]
> — [Speaker], Page [N]

**Bill Language:**
> [Quote]
> — Section [X]

### Timeline
[Hearing] → [Bill] = [N] days

### Sponsor at Hearing?
[Yes/No]
```

---

## Red Flags (Quality Checks)

- ❌ Paraphrasing instead of quoting
- ❌ Missing page/section references
- ❌ Assuming causation from correlation
- ❌ Ignoring contradicting testimony
- ❌ Not checking for pre-hearing bill versions

---

## Output Checklist

- [ ] Witness list with credentials
- [ ] Claims database with evidence grades
- [ ] Terminology index
- [ ] Match matrix (testimony × bill)
- [ ] Evidence report per connection
- [ ] Noted all contradictions

---

## Time Estimates

| Task | Time |
|------|------|
| Extract 1 hearing transcript | 30-60 min |
| Extract 1 bill | 15-30 min |
| Match + classify | 15-30 min |
| Write report | 20-40 min |
| **Total for 1 hearing + 3 bills** | **2-4 hours** |

---

*See ANALYSIS-METHODOLOGY.md for full details*
