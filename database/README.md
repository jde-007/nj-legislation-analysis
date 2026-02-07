# NJ Legislation Analysis Database

Cross-cutting SQLite database for analyzing scientific testimony influence on legislation.

## Quick Start

```bash
# Rebuild database from scratch
sqlite3 legislation.db < schema.sql
sqlite3 legislation.db < seed_analyzed.sql

# Query with helper script
python3 query.py scientists      # List all scientists
python3 query.py hearings        # List hearings with stats
python3 query.py claims Swan     # Claims by Dr. Swan
python3 query.py transfers       # Terminology transfers
python3 query.py effectiveness   # Compare hearing effectiveness

# Direct SQL
python3 query.py sql "SELECT * FROM bills WHERE topic='plastic'"
sqlite3 legislation.db "SELECT name, expertise_area FROM witnesses"
```

## Schema Overview

### Core Tables

| Table | Description |
|-------|-------------|
| `hearings` | Legislative hearing events |
| `witnesses` | People who testified (scientists, advocates, etc.) |
| `testimony` | A witness's appearance at a specific hearing |
| `claims` | Scientific claims made during testimony |
| `evidence` | Evidence cited to support claims |
| `bills` | Related legislation |

### Analysis Tables

| Table | Description |
|-------|-------------|
| `terminology_transfers` | When bill language mirrors testimony language |
| `bill_hearing_links` | Relationships between bills and hearings |
| `legislator_attendance` | Which legislators attended which hearings |
| `hearing_metrics` | Aggregate effectiveness scores per hearing |

### Key Views

- `scientist_effectiveness` - Scientists ranked by claims, evidence quality, and influence
- `hearing_summary` - Hearings with key metrics

## Evidence Quality Tiers

| Tier | Type | Description |
|------|------|-------------|
| 1 | Peer-reviewed | Published, replicated research |
| 2 | Government/Institutional | Official data, agency reports |
| 3 | Single study | Unpublished or single-source |
| 4 | Anecdotal | Personal experience, unattributed claims |

## Transfer Types

| Type | Description |
|------|-------------|
| `TERMINOLOGICAL_TRANSFER` | Bill uses exact/near-exact terms from testimony |
| `SUBSTANTIVE_ALIGNMENT` | Bill adopts policy approach from testimony |
| `EVIDENTIARY_CONTRADICTION` | Bill contradicts testimony evidence |

## Example Queries

```sql
-- Which scientists had their terms adopted in bills?
SELECT w.name, COUNT(tt.id) as terms_adopted
FROM witnesses w
JOIN testimony t ON w.id = t.witness_id
JOIN claims c ON t.id = c.testimony_id
JOIN terminology_transfers tt ON c.id = tt.claim_id
GROUP BY w.id ORDER BY terms_adopted DESC;

-- Claims with NJ-specific evidence
SELECT w.name, c.claim_text
FROM claims c
JOIN evidence e ON c.id = e.claim_id
JOIN testimony t ON c.testimony_id = t.id
JOIN witnesses w ON t.witness_id = w.id
WHERE e.is_nj_specific = 1;

-- Bills introduced after hearings vs before
SELECT 
    relationship,
    COUNT(*) as count,
    AVG(days_between) as avg_days
FROM bill_hearing_links
GROUP BY relationship;
```

## Adding New Hearings

1. Create a new hearing analysis folder: `nj-YYYY-MM-DD-topic/`
2. Add `ANALYSIS.md` following the template in `templates/`
3. Add INSERT statements to `seed_analyzed.sql` or create a new seed file
4. Run: `sqlite3 legislation.db < your_new_seed.sql`
