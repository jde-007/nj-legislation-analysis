-- NJ Legislation Analysis Database v2
-- Expanded schema with committee structure, bill actions, and Eagleton fellows tracking

-- ============================================================
-- ORGANIZATIONAL STRUCTURE
-- ============================================================

-- Committees: Standing committees, joint committees, task forces, councils, commissions
CREATE TABLE IF NOT EXISTS committees (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    chamber TEXT,                          -- senate, assembly, joint, other
    committee_type TEXT NOT NULL,          -- standing, joint, taskforce, council, commission
    parent_committee_id INTEGER REFERENCES committees(id),
    website_url TEXT,
    UNIQUE(name, chamber)
);

-- ============================================================
-- PEOPLE
-- ============================================================

-- People: Unified table for all individuals (legislators, witnesses, staff, etc.)
CREATE TABLE IF NOT EXISTS people (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    title TEXT,                            -- e.g., "Senator", "Associate Professor"
    affiliation TEXT,                      -- e.g., "Rutgers University", "District 15"
    department TEXT,
    expertise_area TEXT,
    person_type TEXT,                      -- legislator, scientist, advocate, industry, government, citizen, staff
    party TEXT,                            -- D, R, I (for legislators)
    district TEXT,                         -- for legislators
    is_eagleton_fellow INTEGER DEFAULT 0,  -- Flag for Eagleton Science Fellows
    eagleton_fellowship_year TEXT,         -- Year(s) of fellowship
    email TEXT,
    notes TEXT,
    UNIQUE(name, affiliation)
);

-- ============================================================
-- HEARINGS
-- ============================================================

-- Hearings: The legislative hearing events
CREATE TABLE IF NOT EXISTS hearings (
    id INTEGER PRIMARY KEY,
    date TEXT NOT NULL,                    -- YYYY-MM-DD
    title TEXT NOT NULL,
    topic TEXT NOT NULL,                   -- e.g., "plastic-pollution", "climate-resiliency"
    location TEXT,
    transcript_path TEXT,                  -- relative path to transcript
    pdf_path TEXT,                         -- relative path to PDF
    committee_notice_path TEXT,            -- relative path to committee notice/agenda
    source_url TEXT,                       -- NJ Legislature URL
    total_witnesses INTEGER,
    scientist_witnesses INTEGER,
    analysis_status TEXT DEFAULT 'pending' -- pending, in-progress, complete
);

-- Hearing-Committee Links: Which committees held/co-held the hearing
CREATE TABLE IF NOT EXISTS hearing_committees (
    id INTEGER PRIMARY KEY,
    hearing_id INTEGER NOT NULL REFERENCES hearings(id),
    committee_id INTEGER NOT NULL REFERENCES committees(id),
    role TEXT DEFAULT 'primary',           -- primary, co-host, joint
    UNIQUE(hearing_id, committee_id)
);

-- Hearing Attendance: All people present at hearings (legislators, staff, observers)
CREATE TABLE IF NOT EXISTS hearing_attendance (
    id INTEGER PRIMARY KEY,
    hearing_id INTEGER NOT NULL REFERENCES hearings(id),
    person_id INTEGER NOT NULL REFERENCES people(id),
    role TEXT,                             -- chair, vice-chair, member, guest, staff, observer
    attendance_type TEXT,                  -- committee_member, witness, also_present, staff
    UNIQUE(hearing_id, person_id)
);

-- ============================================================
-- BILLS
-- ============================================================

-- Bills: Legislation
CREATE TABLE IF NOT EXISTS bills (
    id INTEGER PRIMARY KEY,
    bill_number TEXT NOT NULL,             -- e.g., "A4367"
    title TEXT,
    session TEXT,                          -- e.g., "2024-2025"
    introduced_date TEXT,                  -- YYYY-MM-DD
    primary_sponsor_id INTEGER REFERENCES people(id),
    status TEXT,                           -- introduced, committee, passed, signed, failed
    topic TEXT,                            -- plastic, climate, etc.
    bill_text_path TEXT,                   -- relative path to extracted text
    pdf_path TEXT,
    synopsis TEXT,
    UNIQUE(bill_number, session)
);

-- Bill Sponsors: All sponsors of a bill
CREATE TABLE IF NOT EXISTS bill_sponsors (
    id INTEGER PRIMARY KEY,
    bill_id INTEGER NOT NULL REFERENCES bills(id),
    person_id INTEGER NOT NULL REFERENCES people(id),
    sponsor_type TEXT DEFAULT 'sponsor',   -- primary, sponsor, cosponsor
    UNIQUE(bill_id, person_id)
);

-- Bills on Hearing Agenda: Bills referenced in hearing agenda
CREATE TABLE IF NOT EXISTS hearing_agenda_bills (
    id INTEGER PRIMARY KEY,
    hearing_id INTEGER NOT NULL REFERENCES hearings(id),
    bill_id INTEGER NOT NULL REFERENCES bills(id),
    agenda_order INTEGER,                  -- order on agenda
    scheduled_action TEXT,                 -- discussion, testimony, vote
    UNIQUE(hearing_id, bill_id)
);

-- Bill Actions at Hearings: Votes and other actions taken on bills
CREATE TABLE IF NOT EXISTS hearing_bill_actions (
    id INTEGER PRIMARY KEY,
    hearing_id INTEGER NOT NULL REFERENCES hearings(id),
    bill_id INTEGER NOT NULL REFERENCES bills(id),
    action_type TEXT NOT NULL,             -- vote, amendment, substitution, held, released, tabled
    action_result TEXT,                    -- passed, failed, amended, held
    vote_yes INTEGER,
    vote_no INTEGER,
    vote_abstain INTEGER,
    notes TEXT,
    UNIQUE(hearing_id, bill_id, action_type)
);

-- Bill-Hearing Relationship (general): Overall relationship between bills and hearings
CREATE TABLE IF NOT EXISTS bill_hearing_links (
    id INTEGER PRIMARY KEY,
    bill_id INTEGER NOT NULL REFERENCES bills(id),
    hearing_id INTEGER NOT NULL REFERENCES hearings(id),
    relationship TEXT,                     -- pre-hearing, post-hearing, discussed, agenda
    days_between INTEGER,                  -- days from hearing to bill intro (if post)
    UNIQUE(bill_id, hearing_id)
);

-- ============================================================
-- TESTIMONY
-- ============================================================

-- Testimony: A witness's appearance at a hearing
CREATE TABLE IF NOT EXISTS testimony (
    id INTEGER PRIMARY KEY,
    hearing_id INTEGER NOT NULL REFERENCES hearings(id),
    person_id INTEGER NOT NULL REFERENCES people(id),
    summary TEXT,                          -- brief summary of testimony
    page_start INTEGER,                    -- transcript page reference
    page_end INTEGER,
    testimony_date TEXT,                   -- if different from hearing date
    written_testimony_path TEXT,           -- path to written testimony if submitted
    UNIQUE(hearing_id, person_id)
);

-- Testimony Bill Positions: Which bills testimony addressed and position taken
CREATE TABLE IF NOT EXISTS testimony_bill_positions (
    id INTEGER PRIMARY KEY,
    testimony_id INTEGER NOT NULL REFERENCES testimony(id),
    bill_id INTEGER NOT NULL REFERENCES bills(id),
    position TEXT NOT NULL,                -- for, against, neutral, mixed
    position_summary TEXT,                 -- brief explanation of position
    UNIQUE(testimony_id, bill_id)
);

-- ============================================================
-- CLAIMS & EVIDENCE
-- ============================================================

-- Claims: Scientific claims made during testimony
CREATE TABLE IF NOT EXISTS claims (
    id INTEGER PRIMARY KEY,
    testimony_id INTEGER NOT NULL REFERENCES testimony(id),
    claim_text TEXT NOT NULL,              -- the actual claim
    claim_type TEXT,                       -- empirical, causal, predictive, policy-recommendation
    topic_tags TEXT,                       -- comma-separated: "microplastics,health,water"
    page_reference INTEGER                 -- transcript page
);

-- Claim-Bill Positions: Which bill(s) each claim was presented regarding
-- and whether the claim supports, opposes, or is neutral to the bill
CREATE TABLE IF NOT EXISTS claim_bill_positions (
    id INTEGER PRIMARY KEY,
    claim_id INTEGER NOT NULL REFERENCES claims(id),
    bill_id INTEGER NOT NULL REFERENCES bills(id),
    position TEXT NOT NULL,                -- for, against, neutral
    position_notes TEXT,                   -- explanation of how claim relates to bill
    UNIQUE(claim_id, bill_id)
);

-- Evidence: Evidence cited for claims with full citation details
CREATE TABLE IF NOT EXISTS evidence (
    id INTEGER PRIMARY KEY,
    claim_id INTEGER NOT NULL REFERENCES claims(id),
    evidence_text TEXT NOT NULL,           -- description of evidence cited
    evidence_type TEXT,                    -- peer-reviewed, government-data, institutional, anecdotal
    quality_tier INTEGER,                  -- 1=peer-reviewed, 2=govt/institutional, 3=single-study, 4=anecdotal
    source_citation TEXT,                  -- brief citation reference
    is_nj_specific INTEGER DEFAULT 0,      -- NJ-specific data (more persuasive)
    -- Full citation details
    authors TEXT,                          -- Author list (Last F, Last F, et al.)
    title TEXT,                            -- Publication/report title
    journal TEXT,                          -- Journal or publication name
    publication_date TEXT,                 -- YYYY-MM-DD or YYYY
    volume TEXT,                           -- Volume(issue)
    pages TEXT,                            -- Page range
    doi TEXT,                              -- Digital Object Identifier
    url TEXT,                              -- Direct URL to source
    accessed_date TEXT                     -- When source was accessed
);

-- ============================================================
-- INFLUENCE TRACKING
-- ============================================================

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

-- ============================================================
-- METRICS
-- ============================================================

-- Analysis Metrics: Aggregate stats per hearing
CREATE TABLE IF NOT EXISTS hearing_metrics (
    hearing_id INTEGER PRIMARY KEY REFERENCES hearings(id),
    total_claims INTEGER,
    strong_evidence_pct REAL,              -- % claims with tier 1-2 evidence
    nj_specific_pct REAL,                  -- % claims citing NJ data
    avg_evidence_quality REAL,             -- average tier (lower=better)
    terminology_transfers INTEGER,         -- count of terms adopted in bills
    effectiveness_score REAL               -- composite score 0-100
);

-- ============================================================
-- EAGLETON SCIENCE FELLOWS
-- ============================================================

-- Eagleton Fellows: Master list of all Eagleton Science Fellows
CREATE TABLE IF NOT EXISTS eagleton_fellows (
    id INTEGER PRIMARY KEY,
    person_id INTEGER NOT NULL REFERENCES people(id),
    fellowship_year TEXT NOT NULL,         -- e.g., "2020-2021"
    track TEXT,                            -- legislative, executive, climate-action
    placement TEXT,                        -- e.g., "Senate Democratic Office"
    placement_department TEXT,
    UNIQUE(person_id, fellowship_year)
);

-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_hearings_topic ON hearings(topic);
CREATE INDEX IF NOT EXISTS idx_hearings_date ON hearings(date);
CREATE INDEX IF NOT EXISTS idx_people_type ON people(person_type);
CREATE INDEX IF NOT EXISTS idx_people_eagleton ON people(is_eagleton_fellow);
CREATE INDEX IF NOT EXISTS idx_claims_testimony ON claims(testimony_id);
CREATE INDEX IF NOT EXISTS idx_evidence_claim ON evidence(claim_id);
CREATE INDEX IF NOT EXISTS idx_bills_topic ON bills(topic);
CREATE INDEX IF NOT EXISTS idx_terminology_bill ON terminology_transfers(bill_id);
CREATE INDEX IF NOT EXISTS idx_testimony_bill_pos ON testimony_bill_positions(testimony_id);
CREATE INDEX IF NOT EXISTS idx_hearing_attendance ON hearing_attendance(hearing_id);

-- ============================================================
-- VIEWS
-- ============================================================

-- Eagleton Fellows at hearings
CREATE VIEW IF NOT EXISTS eagleton_at_hearings AS
SELECT 
    h.date,
    h.title,
    p.name as fellow_name,
    ha.role,
    ef.fellowship_year,
    ef.track,
    ef.placement
FROM hearing_attendance ha
JOIN hearings h ON ha.hearing_id = h.id
JOIN people p ON ha.person_id = p.id
JOIN eagleton_fellows ef ON p.id = ef.person_id
WHERE p.is_eagleton_fellow = 1;

-- Testimony with bill positions
CREATE VIEW IF NOT EXISTS testimony_positions AS
SELECT 
    h.date,
    h.title as hearing,
    p.name as witness,
    p.affiliation,
    b.bill_number,
    b.title as bill_title,
    tbp.position,
    tbp.position_summary
FROM testimony t
JOIN hearings h ON t.hearing_id = h.id
JOIN people p ON t.person_id = p.id
JOIN testimony_bill_positions tbp ON t.id = tbp.testimony_id
JOIN bills b ON tbp.bill_id = b.id
ORDER BY h.date, p.name;

-- Bills on hearing agendas with actions
CREATE VIEW IF NOT EXISTS hearing_bill_status AS
SELECT 
    h.date,
    h.title as hearing,
    b.bill_number,
    b.title as bill_title,
    hab.scheduled_action,
    hba.action_type,
    hba.action_result,
    hba.vote_yes,
    hba.vote_no
FROM hearing_agenda_bills hab
JOIN hearings h ON hab.hearing_id = h.id
JOIN bills b ON hab.bill_id = b.id
LEFT JOIN hearing_bill_actions hba ON hab.hearing_id = hba.hearing_id AND hab.bill_id = hba.bill_id
ORDER BY h.date, hab.agenda_order;
