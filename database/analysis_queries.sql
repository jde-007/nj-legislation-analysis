-- Analysis Queries: Fellow Impact on Evidence Quality
-- These queries answer the core research question:
-- "How does Science Fellow involvement impact evidence quality in hearings and bills?"

-- ============================================================
-- QUERY 1: Evidence per hearing over time
-- ============================================================

-- Total scientific evidence presented per hearing
CREATE VIEW IF NOT EXISTS evidence_per_hearing AS
SELECT 
    h.id as hearing_id,
    h.date,
    h.title,
    h.topic,
    COUNT(DISTINCT c.id) as total_claims,
    COUNT(DISTINCT CASE WHEN e.quality_tier = 1 THEN c.id END) as tier1_claims,
    COUNT(DISTINCT CASE WHEN e.quality_tier = 2 THEN c.id END) as tier2_claims,
    COUNT(DISTINCT CASE WHEN e.quality_tier <= 2 THEN c.id END) as strong_evidence_claims,
    ROUND(AVG(e.quality_tier), 2) as avg_evidence_tier,
    COUNT(DISTINCT CASE WHEN e.is_nj_specific = 1 THEN c.id END) as nj_specific_claims,
    h.scientist_witnesses,
    hm.effectiveness_score
FROM hearings h
LEFT JOIN testimony t ON h.id = t.hearing_id
LEFT JOIN claims c ON t.id = c.testimony_id
LEFT JOIN evidence e ON c.id = e.claim_id
LEFT JOIN hearing_metrics hm ON h.id = hm.hearing_id
GROUP BY h.id
ORDER BY h.date;

-- ============================================================
-- QUERY 2: Hearings WITH vs WITHOUT Fellow involvement
-- ============================================================

-- Flag hearings that had an Eagleton Fellow present
-- Note: Uses both hearing_attendance (new) and testimony (legacy) to find Fellows
CREATE VIEW IF NOT EXISTS hearing_fellow_presence AS
SELECT 
    h.id as hearing_id,
    h.date,
    h.title,
    CASE WHEN COUNT(DISTINCT CASE WHEN p.is_eagleton_fellow = 1 THEN p.id END) > 0 
         THEN 1 ELSE 0 END as has_fellow,
    COUNT(DISTINCT CASE WHEN p.is_eagleton_fellow = 1 THEN p.id END) as fellow_count,
    GROUP_CONCAT(DISTINCT CASE WHEN p.is_eagleton_fellow = 1 THEN p.name END) as fellows_present
FROM hearings h
LEFT JOIN hearing_attendance ha ON h.id = ha.hearing_id
LEFT JOIN people p ON ha.person_id = p.id
-- Also check witnesses table for legacy data
LEFT JOIN testimony t ON h.id = t.hearing_id
LEFT JOIN witnesses w ON t.witness_id = w.id
LEFT JOIN people pw ON w.name = pw.name AND pw.is_eagleton_fellow = 1
GROUP BY h.id;

-- Compare metrics: hearings with Fellow vs without
CREATE VIEW IF NOT EXISTS fellow_impact_comparison AS
SELECT 
    hfp.has_fellow,
    CASE WHEN hfp.has_fellow = 1 THEN 'With Fellow' ELSE 'Without Fellow' END as group_name,
    COUNT(*) as hearing_count,
    ROUND(AVG(eph.total_claims), 1) as avg_claims,
    ROUND(AVG(eph.strong_evidence_claims), 1) as avg_strong_claims,
    ROUND(AVG(eph.avg_evidence_tier), 2) as avg_tier,
    ROUND(AVG(eph.scientist_witnesses), 1) as avg_scientists,
    ROUND(AVG(eph.effectiveness_score), 1) as avg_effectiveness
FROM hearing_fellow_presence hfp
JOIN evidence_per_hearing eph ON hfp.hearing_id = eph.hearing_id
GROUP BY hfp.has_fellow;

-- ============================================================
-- QUERY 3: Bill EBLS by Fellow involvement
-- ============================================================

-- Flag bills that had Fellow involvement (testified, on staff, drafted)
CREATE VIEW IF NOT EXISTS bill_fellow_involvement AS
SELECT 
    b.id as bill_id,
    b.bill_number,
    b.title,
    CASE WHEN COUNT(DISTINCT CASE WHEN p.is_eagleton_fellow = 1 THEN p.id END) > 0 
         THEN 1 ELSE 0 END as has_fellow_involvement,
    GROUP_CONCAT(DISTINCT CASE WHEN p.is_eagleton_fellow = 1 THEN p.name END) as fellows_involved
FROM bills b
LEFT JOIN bill_hearing_links bhl ON b.id = bhl.bill_id
LEFT JOIN hearings h ON bhl.hearing_id = h.id
LEFT JOIN testimony t ON h.id = t.hearing_id
LEFT JOIN witnesses w ON t.witness_id = w.id
LEFT JOIN people p ON w.name = p.name
GROUP BY b.id;

-- ============================================================
-- QUERY 4: Terminology transfers from Fellows vs non-Fellows
-- ============================================================

CREATE VIEW IF NOT EXISTS terminology_transfer_by_source AS
SELECT 
    CASE WHEN p.is_eagleton_fellow = 1 THEN 'Eagleton Fellow' ELSE 'Non-Fellow Scientist' END as source_type,
    COUNT(*) as transfer_count,
    COUNT(DISTINCT tt.bill_id) as bills_influenced,
    GROUP_CONCAT(DISTINCT b.bill_number) as bill_numbers
FROM terminology_transfers tt
LEFT JOIN claims c ON tt.claim_id = c.id
LEFT JOIN testimony t ON c.testimony_id = t.id
LEFT JOIN witnesses w ON t.witness_id = w.id
LEFT JOIN people p ON w.name = p.name
LEFT JOIN bills b ON tt.bill_id = b.id
GROUP BY CASE WHEN p.is_eagleton_fellow = 1 THEN 1 ELSE 0 END;

-- ============================================================
-- QUERY 5: Evidence quality trend over time
-- ============================================================

CREATE VIEW IF NOT EXISTS evidence_trend_by_year AS
SELECT 
    strftime('%Y', h.date) as year,
    COUNT(*) as hearing_count,
    ROUND(AVG(eph.total_claims), 1) as avg_claims,
    ROUND(AVG(eph.avg_evidence_tier), 2) as avg_tier,
    ROUND(100.0 * SUM(eph.strong_evidence_claims) / NULLIF(SUM(eph.total_claims), 0), 1) as strong_evidence_pct,
    SUM(CASE WHEN hfp.has_fellow = 1 THEN 1 ELSE 0 END) as hearings_with_fellow
FROM hearings h
JOIN evidence_per_hearing eph ON h.id = eph.hearing_id
JOIN hearing_fellow_presence hfp ON h.id = hfp.hearing_id
GROUP BY strftime('%Y', h.date)
ORDER BY year;

-- ============================================================
-- QUERY 6: Committee-level Fellow impact
-- ============================================================

CREATE VIEW IF NOT EXISTS committee_fellow_impact AS
SELECT 
    c.name as committee_name,
    COUNT(DISTINCT h.id) as total_hearings,
    SUM(CASE WHEN hfp.has_fellow = 1 THEN 1 ELSE 0 END) as hearings_with_fellow,
    ROUND(AVG(CASE WHEN hfp.has_fellow = 1 THEN eph.avg_evidence_tier END), 2) as avg_tier_with_fellow,
    ROUND(AVG(CASE WHEN hfp.has_fellow = 0 THEN eph.avg_evidence_tier END), 2) as avg_tier_without_fellow,
    ROUND(AVG(CASE WHEN hfp.has_fellow = 1 THEN eph.effectiveness_score END), 1) as effectiveness_with_fellow,
    ROUND(AVG(CASE WHEN hfp.has_fellow = 0 THEN eph.effectiveness_score END), 1) as effectiveness_without_fellow
FROM committees c
JOIN hearing_committees hc ON c.id = hc.committee_id
JOIN hearings h ON hc.hearing_id = h.id
JOIN evidence_per_hearing eph ON h.id = eph.hearing_id
JOIN hearing_fellow_presence hfp ON h.id = hfp.hearing_id
GROUP BY c.id
HAVING total_hearings > 1;

-- ============================================================
-- SUMMARY QUERIES
-- ============================================================

-- Quick summary: Fellow impact at a glance
-- Run: SELECT * FROM fellow_impact_summary;
CREATE VIEW IF NOT EXISTS fellow_impact_summary AS
SELECT 
    'Hearings analyzed' as metric,
    CAST(COUNT(*) AS TEXT) as value
FROM hearings
UNION ALL
SELECT 
    'Hearings with Fellow present',
    CAST(SUM(has_fellow) AS TEXT)
FROM hearing_fellow_presence
UNION ALL
SELECT 
    'Avg claims (with Fellow)',
    CAST(ROUND(AVG(CASE WHEN hfp.has_fellow = 1 THEN eph.total_claims END), 1) AS TEXT)
FROM evidence_per_hearing eph
JOIN hearing_fellow_presence hfp ON eph.hearing_id = hfp.hearing_id
UNION ALL
SELECT 
    'Avg claims (without Fellow)',
    CAST(ROUND(AVG(CASE WHEN hfp.has_fellow = 0 THEN eph.total_claims END), 1) AS TEXT)
FROM evidence_per_hearing eph
JOIN hearing_fellow_presence hfp ON eph.hearing_id = hfp.hearing_id
UNION ALL
SELECT 
    'Terminology transfers from Fellows',
    CAST(COUNT(*) AS TEXT)
FROM terminology_transfers tt
JOIN claims c ON tt.claim_id = c.id
JOIN testimony t ON c.testimony_id = t.id
JOIN witnesses w ON t.witness_id = w.id
JOIN people p ON w.name = p.name
WHERE p.is_eagleton_fellow = 1;
