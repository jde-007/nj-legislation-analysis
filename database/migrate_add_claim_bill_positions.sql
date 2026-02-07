-- Migration: Add claim_bill_positions table
-- Links scientific claims to the specific bill(s) they support/oppose

-- ============================================================
-- NEW TABLE: Claim-Bill Positions
-- ============================================================

-- Each scientific claim can be made regarding one or more bills
-- with a position (for, against, neutral) for each
CREATE TABLE IF NOT EXISTS claim_bill_positions (
    id INTEGER PRIMARY KEY,
    claim_id INTEGER NOT NULL REFERENCES claims(id),
    bill_id INTEGER NOT NULL REFERENCES bills(id),
    position TEXT NOT NULL,                -- for, against, neutral
    position_notes TEXT,                   -- explanation of how claim relates to bill
    UNIQUE(claim_id, bill_id)
);

-- Index for efficient lookups
CREATE INDEX IF NOT EXISTS idx_claim_bill_pos_claim ON claim_bill_positions(claim_id);
CREATE INDEX IF NOT EXISTS idx_claim_bill_pos_bill ON claim_bill_positions(bill_id);
CREATE INDEX IF NOT EXISTS idx_claim_bill_pos_position ON claim_bill_positions(position);

-- ============================================================
-- VIEW: Claims with bill positions
-- ============================================================

DROP VIEW IF EXISTS claims_with_bill_positions;
CREATE VIEW claims_with_bill_positions AS
SELECT 
    c.id as claim_id,
    c.claim_text,
    c.claim_type,
    h.date as hearing_date,
    h.title as hearing_title,
    w.name as scientist_name,
    w.affiliation as scientist_affiliation,
    b.bill_number,
    b.title as bill_title,
    cbp.position,
    cbp.position_notes,
    e.quality_tier as evidence_tier,
    e.evidence_type
FROM claims c
JOIN testimony t ON c.testimony_id = t.id
JOIN hearings h ON t.hearing_id = h.id
JOIN witnesses w ON t.witness_id = w.id
LEFT JOIN claim_bill_positions cbp ON c.id = cbp.claim_id
LEFT JOIN bills b ON cbp.bill_id = b.id
LEFT JOIN evidence e ON c.id = e.claim_id
ORDER BY h.date, w.name, c.id;

-- ============================================================
-- VIEW: Bill support/opposition from scientific claims
-- ============================================================

DROP VIEW IF EXISTS bill_scientific_support;
CREATE VIEW bill_scientific_support AS
SELECT 
    b.bill_number,
    b.title,
    COUNT(DISTINCT CASE WHEN cbp.position = 'for' THEN c.id END) as claims_for,
    COUNT(DISTINCT CASE WHEN cbp.position = 'against' THEN c.id END) as claims_against,
    COUNT(DISTINCT CASE WHEN cbp.position = 'neutral' THEN c.id END) as claims_neutral,
    COUNT(DISTINCT c.id) as total_claims,
    ROUND(AVG(e.quality_tier), 2) as avg_evidence_tier,
    GROUP_CONCAT(DISTINCT w.name) as scientists
FROM bills b
LEFT JOIN claim_bill_positions cbp ON b.id = cbp.bill_id
LEFT JOIN claims c ON cbp.claim_id = c.id
LEFT JOIN evidence e ON c.id = e.claim_id
LEFT JOIN testimony t ON c.testimony_id = t.id
LEFT JOIN witnesses w ON t.witness_id = w.id
GROUP BY b.id
HAVING total_claims > 0
ORDER BY total_claims DESC;

-- ============================================================
-- Done
-- ============================================================
SELECT 'Migration complete: claim_bill_positions table added';
