-- NJ Legislation Analysis Database
-- Cross-cutting analysis of scientific testimony in legislative hearings

-- Hearings: The legislative hearing events
CREATE TABLE IF NOT EXISTS hearings (
    id INTEGER PRIMARY KEY,
    date TEXT NOT NULL,                    -- YYYY-MM-DD
    title TEXT NOT NULL,
    committee TEXT,                        -- e.g., "Senate Environment and Energy"
    topic TEXT NOT NULL,                   -- e.g., "plastic-pollution", "climate-resiliency"
    location TEXT,
    transcript_path TEXT,                  -- relative path to transcript
    pdf_path TEXT,                         -- relative path to PDF
    source_url TEXT,                       -- NJ Legislature URL
    total_witnesses INTEGER,
    scientist_witnesses INTEGER,
    analysis_status TEXT DEFAULT 'pending' -- pending, in-progress, complete
);

-- Witnesses: People who testified
CREATE TABLE IF NOT EXISTS witnesses (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    title TEXT,                            -- e.g., "Associate Professor"
    affiliation TEXT,                      -- e.g., "Rutgers University"
    department TEXT,                       -- e.g., "Department of Pharmacology"
    expertise_area TEXT,                   -- e.g., "nanoplastics", "atmospheric science"
    witness_type TEXT,                     -- scientist, advocate, industry, government, citizen
    UNIQUE(name, affiliation)
);

-- Testimony: A witness's appearance at a hearing
CREATE TABLE IF NOT EXISTS testimony (
    id INTEGER PRIMARY KEY,
    hearing_id INTEGER NOT NULL REFERENCES hearings(id),
    witness_id INTEGER NOT NULL REFERENCES witnesses(id),
    position TEXT,                         -- support, oppose, neutral, informational
    summary TEXT,                          -- brief summary of testimony
    page_start INTEGER,                    -- transcript page reference
    page_end INTEGER,
    UNIQUE(hearing_id, witness_id)
);

-- Claims: Scientific claims made during testimony
CREATE TABLE IF NOT EXISTS claims (
    id INTEGER PRIMARY KEY,
    testimony_id INTEGER NOT NULL REFERENCES testimony(id),
    claim_text TEXT NOT NULL,              -- the actual claim
    claim_type TEXT,                       -- empirical, causal, predictive, policy-recommendation
    topic_tags TEXT,                       -- comma-separated: "microplastics,health,water"
    page_reference INTEGER                 -- transcript page
);

-- Evidence: Evidence cited for claims
CREATE TABLE IF NOT EXISTS evidence (
    id INTEGER PRIMARY KEY,
    claim_id INTEGER NOT NULL REFERENCES claims(id),
    evidence_text TEXT NOT NULL,           -- description of evidence cited
    evidence_type TEXT,                    -- peer-reviewed, government-data, institutional, anecdotal
    quality_tier INTEGER,                  -- 1=peer-reviewed, 2=govt/institutional, 3=single-study, 4=anecdotal
    source_citation TEXT,                  -- if a specific study was named
    is_nj_specific INTEGER DEFAULT 0       -- NJ-specific data (more persuasive)
);

-- Bills: Legislation related to hearing topics
CREATE TABLE IF NOT EXISTS bills (
    id INTEGER PRIMARY KEY,
    bill_number TEXT NOT NULL UNIQUE,      -- e.g., "A4367"
    title TEXT,
    session TEXT,                          -- e.g., "2024-2025"
    introduced_date TEXT,                  -- YYYY-MM-DD
    sponsors TEXT,                         -- comma-separated sponsor names
    primary_sponsor TEXT,
    status TEXT,                           -- introduced, committee, passed, signed, failed
    topic TEXT,                            -- plastic, climate, etc.
    bill_text_path TEXT,                   -- relative path to extracted text
    pdf_path TEXT
);

-- Bill-Hearing Links: Which bills relate to which hearings
CREATE TABLE IF NOT EXISTS bill_hearing_links (
    id INTEGER PRIMARY KEY,
    bill_id INTEGER NOT NULL REFERENCES bills(id),
    hearing_id INTEGER NOT NULL REFERENCES hearings(id),
    relationship TEXT,                     -- pre-hearing, post-hearing, discussed
    days_between INTEGER,                  -- days from hearing to bill intro (if post)
    UNIQUE(bill_id, hearing_id)
);

-- Terminology Transfers: When bill language mirrors testimony language
CREATE TABLE IF NOT EXISTS terminology_transfers (
    id INTEGER PRIMARY KEY,
    claim_id INTEGER REFERENCES claims(id),
    bill_id INTEGER NOT NULL REFERENCES bills(id),
    testimony_term TEXT NOT NULL,          -- exact term from testimony
    bill_term TEXT NOT NULL,               -- matching term in bill
    bill_section TEXT,                     -- where in bill it appears
    transfer_type TEXT,                    -- TERMINOLOGICAL_TRANSFER, SUBSTANTIVE_ALIGNMENT, EVIDENTIARY_CONTRADICTION
    confidence TEXT,                       -- high, medium, low
    notes TEXT
);

-- Legislator Attendance: Track which legislators attended which hearings
CREATE TABLE IF NOT EXISTS legislator_attendance (
    id INTEGER PRIMARY KEY,
    hearing_id INTEGER NOT NULL REFERENCES hearings(id),
    legislator_name TEXT NOT NULL,
    role TEXT,                             -- chair, member, guest
    later_sponsored_bill INTEGER REFERENCES bills(id),  -- did they sponsor related bill?
    UNIQUE(hearing_id, legislator_name)
);

-- Analysis Metrics: Aggregate stats per hearing
CREATE TABLE IF NOT EXISTS hearing_metrics (
    hearing_id INTEGER PRIMARY KEY REFERENCES hearings(id),
    total_claims INTEGER,
    strong_evidence_pct REAL,              -- % claims with tier 1-2 evidence
    nj_specific_pct REAL,                  -- % claims citing NJ data
    avg_evidence_quality REAL,             -- average tier (lower=better)
    terminology_transfers INTEGER,          -- count of terms adopted in bills
    effectiveness_score REAL               -- composite score 0-100
);

-- Indexes for common queries
CREATE INDEX IF NOT EXISTS idx_hearings_topic ON hearings(topic);
CREATE INDEX IF NOT EXISTS idx_hearings_date ON hearings(date);
CREATE INDEX IF NOT EXISTS idx_witnesses_type ON witnesses(witness_type);
CREATE INDEX IF NOT EXISTS idx_claims_testimony ON claims(testimony_id);
CREATE INDEX IF NOT EXISTS idx_evidence_claim ON evidence(claim_id);
CREATE INDEX IF NOT EXISTS idx_bills_topic ON bills(topic);
CREATE INDEX IF NOT EXISTS idx_terminology_bill ON terminology_transfers(bill_id);

-- Views for common analysis queries

-- Scientists and their claim counts
CREATE VIEW IF NOT EXISTS scientist_effectiveness AS
SELECT 
    w.name,
    w.affiliation,
    w.expertise_area,
    COUNT(DISTINCT t.hearing_id) as hearings_attended,
    COUNT(c.id) as total_claims,
    AVG(e.quality_tier) as avg_evidence_quality,
    SUM(CASE WHEN e.is_nj_specific = 1 THEN 1 ELSE 0 END) as nj_specific_claims,
    COUNT(DISTINCT tt.id) as terminology_transfers
FROM witnesses w
JOIN testimony t ON w.id = t.witness_id
LEFT JOIN claims c ON t.id = c.testimony_id
LEFT JOIN evidence e ON c.id = e.claim_id
LEFT JOIN terminology_transfers tt ON c.id = tt.claim_id
WHERE w.witness_type = 'scientist'
GROUP BY w.id;

-- Hearing effectiveness summary
CREATE VIEW IF NOT EXISTS hearing_summary AS
SELECT 
    h.date,
    h.title,
    h.topic,
    h.scientist_witnesses,
    hm.total_claims,
    hm.strong_evidence_pct,
    hm.terminology_transfers,
    hm.effectiveness_score
FROM hearings h
LEFT JOIN hearing_metrics hm ON h.id = hm.hearing_id
ORDER BY h.date DESC;
