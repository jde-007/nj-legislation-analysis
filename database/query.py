#!/usr/bin/env python3
# Run with: python3 query.py <command>
"""
Query helper for NJ Legislation Analysis database.

Usage:
    python query.py scientists          # List all scientists and their stats
    python query.py hearings            # List all hearings
    python query.py claims [witness]    # Show claims, optionally by witness
    python query.py transfers           # Show terminology transfers
    python query.py effectiveness       # Show hearing effectiveness metrics
    python query.py sql "SELECT ..."    # Run arbitrary SQL
"""

import sqlite3
import sys
from pathlib import Path

DB_PATH = Path(__file__).parent / "legislation.db"

def get_db():
    return sqlite3.connect(DB_PATH)

def print_table(cursor, headers=True):
    """Print query results as formatted table."""
    rows = cursor.fetchall()
    if not rows:
        print("No results.")
        return
    
    cols = [d[0] for d in cursor.description]
    widths = [max(len(str(row[i])) for row in rows + [tuple(cols)]) for i in range(len(cols))]
    
    if headers:
        print(" | ".join(col.ljust(widths[i]) for i, col in enumerate(cols)))
        print("-+-".join("-" * w for w in widths))
    
    for row in rows:
        print(" | ".join(str(v).ljust(widths[i]) if v is not None else "".ljust(widths[i]) for i, v in enumerate(row)))

def cmd_scientists():
    """List scientists with their hearing counts and claim stats."""
    db = get_db()
    cur = db.execute("""
        SELECT 
            w.name,
            w.affiliation,
            w.expertise_area,
            COUNT(DISTINCT t.hearing_id) as hearings,
            COUNT(c.id) as claims,
            ROUND(AVG(e.quality_tier), 1) as avg_quality
        FROM witnesses w
        LEFT JOIN testimony t ON w.id = t.witness_id
        LEFT JOIN claims c ON t.id = c.testimony_id
        LEFT JOIN evidence e ON c.id = e.claim_id
        WHERE w.witness_type = 'scientist'
        GROUP BY w.id
        ORDER BY claims DESC
    """)
    print_table(cur)

def cmd_hearings():
    """List all hearings with key stats."""
    db = get_db()
    cur = db.execute("""
        SELECT 
            h.date,
            h.title,
            h.scientist_witnesses as scientists,
            hm.total_claims as claims,
            hm.strong_evidence_pct as strong_pct,
            hm.terminology_transfers as transfers,
            hm.effectiveness_score as score,
            h.analysis_status as status
        FROM hearings h
        LEFT JOIN hearing_metrics hm ON h.id = hm.hearing_id
        ORDER BY h.date DESC
    """)
    print_table(cur)

def cmd_claims(witness=None):
    """List claims, optionally filtered by witness name."""
    db = get_db()
    if witness:
        cur = db.execute("""
            SELECT w.name, c.claim_text, c.claim_type, e.quality_tier
            FROM claims c
            JOIN testimony t ON c.testimony_id = t.id
            JOIN witnesses w ON t.witness_id = w.id
            LEFT JOIN evidence e ON c.id = e.claim_id
            WHERE w.name LIKE ?
            ORDER BY w.name, c.id
        """, (f"%{witness}%",))
    else:
        cur = db.execute("""
            SELECT w.name, c.claim_text, c.claim_type, e.quality_tier
            FROM claims c
            JOIN testimony t ON c.testimony_id = t.id
            JOIN witnesses w ON t.witness_id = w.id
            LEFT JOIN evidence e ON c.id = e.claim_id
            ORDER BY w.name, c.id
        """)
    print_table(cur)

def cmd_transfers():
    """Show terminology transfers between testimony and bills."""
    db = get_db()
    cur = db.execute("""
        SELECT 
            b.bill_number,
            tt.testimony_term,
            tt.bill_term,
            tt.transfer_type,
            tt.confidence,
            w.name as witness
        FROM terminology_transfers tt
        JOIN bills b ON tt.bill_id = b.id
        LEFT JOIN claims c ON tt.claim_id = c.id
        LEFT JOIN testimony t ON c.testimony_id = t.id
        LEFT JOIN witnesses w ON t.witness_id = w.id
        ORDER BY b.bill_number
    """)
    print_table(cur)

def cmd_effectiveness():
    """Show hearing effectiveness comparison."""
    db = get_db()
    cur = db.execute("""
        SELECT 
            h.date,
            h.topic,
            hm.total_claims,
            hm.strong_evidence_pct || '%' as strong_evidence,
            hm.nj_specific_pct || '%' as nj_specific,
            hm.avg_evidence_quality as avg_tier,
            hm.terminology_transfers,
            hm.effectiveness_score
        FROM hearings h
        JOIN hearing_metrics hm ON h.id = hm.hearing_id
        ORDER BY hm.effectiveness_score DESC
    """)
    print_table(cur)

def cmd_sql(query):
    """Run arbitrary SQL."""
    db = get_db()
    cur = db.execute(query)
    print_table(cur)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(1)
    
    cmd = sys.argv[1]
    
    if cmd == "scientists":
        cmd_scientists()
    elif cmd == "hearings":
        cmd_hearings()
    elif cmd == "claims":
        witness = sys.argv[2] if len(sys.argv) > 2 else None
        cmd_claims(witness)
    elif cmd == "transfers":
        cmd_transfers()
    elif cmd == "effectiveness":
        cmd_effectiveness()
    elif cmd == "sql":
        if len(sys.argv) < 3:
            print("Usage: python query.py sql \"SELECT ...\"")
            sys.exit(1)
        cmd_sql(sys.argv[2])
    else:
        print(f"Unknown command: {cmd}")
        print(__doc__)
        sys.exit(1)
