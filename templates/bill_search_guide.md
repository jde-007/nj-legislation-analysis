# Bill Search Guide

The NJ Legislature website (njleg.state.nj.us) doesn't have a public API, so bill searches require browser-based interaction.

## Finding Bills Related to a Hearing

### Step 1: Check the Transcript

Search the transcript for explicit bill references:

```bash
# Bill patterns: S####, A####, S-####, A-####
grep -iE '[SA][- ]?[0-9]{3,5}' transcript.txt | sort -u

# Named legislation
grep -iE '(bill|legislation|statute|law)' transcript.txt | head -50
```

### Step 2: Advanced Search on NJ Legislature

1. Go to: https://www.njleg.state.nj.us/advanced-search
2. Enter keywords from the hearing topic
3. Select the relevant session (2024-2025, etc.)
4. Optionally filter by committee
5. Click Search

**Tips:**
- Try multiple keyword variations (e.g., "plastic", "microplastic", "single-use")
- Search without committee filter if no results
- Check multiple sessions (bills often carry over)

### Step 3: Get Bill Details

For each relevant bill:
1. Go to: `https://www.njleg.state.nj.us/bill-search/2024/S####`
2. Capture:
   - Bill number and title
   - Primary sponsor
   - Current status
   - Committee referrals
   - Full text link
   - Committee statement (if available)

### Step 4: Document in Analysis

Add to ANALYSIS.md:

```markdown
## Part III: Legislative Outcomes

### Bills Discussed During Hearing

| Bill # | Title | Status | URL |
|--------|-------|--------|-----|
| S1234 | Title here | Pending | [Link](https://...) |

### Bill Text Analysis

Compare testimony claims to bill language...
```

## Known Bill Patterns by Topic

### Plastic Pollution (2024)
- Search terms: plastic, microplastic, single-use, bag, polystyrene, recycling
- Related subjects: ENVIRONMENT - SOLID WASTE AND RECYCLING

### Climate Resiliency (2024)
- Search terms: climate, resilience, flood, coastal, sea level, storm
- Related subjects: ENVIRONMENT - FLOODING, DAMS AND LAKES; ENVIRONMENT - BEACHES AND SHORES

### Clean Energy (2024)
- Search terms: clean energy, renewable, solar, wind, offshore, net-zero
- Related subjects: ENERGY; ENERGY - CONSERVATION; ALTERNATIVE ENERGY SOURCES

## Useful URLs

- **Bill Search:** https://www.njleg.state.nj.us/bill-search
- **Advanced Search:** https://www.njleg.state.nj.us/advanced-search
- **Chapter Laws:** https://www.njleg.state.nj.us/chapter-laws
- **Statutes:** https://lis.njleg.state.nj.us/nxt/gateway.dll/statutes/1

## Notes

- The site uses reCAPTCHA and JS rendering, making automated scraping difficult
- Bill searches are session-specific (2024-2025, 2022-2023, etc.)
- Many environment bills go through Senate Environment and Energy Committee
- Assembly equivalent: Environment, Natural Resources, and Solid Waste
