-- Migration from schema v1 to v2
-- Preserves existing data while adding new structure

-- ============================================================
-- STEP 1: Create new tables (won't affect existing)
-- ============================================================

-- Committees
CREATE TABLE IF NOT EXISTS committees (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    chamber TEXT,
    committee_type TEXT NOT NULL,
    parent_committee_id INTEGER REFERENCES committees(id),
    website_url TEXT,
    UNIQUE(name, chamber)
);

-- People (unified table - will migrate witnesses)
CREATE TABLE IF NOT EXISTS people (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    title TEXT,
    affiliation TEXT,
    department TEXT,
    expertise_area TEXT,
    person_type TEXT,
    party TEXT,
    district TEXT,
    is_eagleton_fellow INTEGER DEFAULT 0,
    eagleton_fellowship_year TEXT,
    email TEXT,
    notes TEXT,
    UNIQUE(name, affiliation)
);

-- Hearing committees link
CREATE TABLE IF NOT EXISTS hearing_committees (
    id INTEGER PRIMARY KEY,
    hearing_id INTEGER NOT NULL,
    committee_id INTEGER NOT NULL,
    role TEXT DEFAULT 'primary',
    UNIQUE(hearing_id, committee_id)
);

-- Hearing attendance (all people present)
CREATE TABLE IF NOT EXISTS hearing_attendance (
    id INTEGER PRIMARY KEY,
    hearing_id INTEGER NOT NULL,
    person_id INTEGER NOT NULL,
    role TEXT,
    attendance_type TEXT,
    UNIQUE(hearing_id, person_id)
);

-- Bill sponsors
CREATE TABLE IF NOT EXISTS bill_sponsors (
    id INTEGER PRIMARY KEY,
    bill_id INTEGER NOT NULL,
    person_id INTEGER NOT NULL,
    sponsor_type TEXT DEFAULT 'sponsor',
    UNIQUE(bill_id, person_id)
);

-- Hearing agenda bills
CREATE TABLE IF NOT EXISTS hearing_agenda_bills (
    id INTEGER PRIMARY KEY,
    hearing_id INTEGER NOT NULL,
    bill_id INTEGER NOT NULL,
    agenda_order INTEGER,
    scheduled_action TEXT,
    UNIQUE(hearing_id, bill_id)
);

-- Bill actions at hearings
CREATE TABLE IF NOT EXISTS hearing_bill_actions (
    id INTEGER PRIMARY KEY,
    hearing_id INTEGER NOT NULL,
    bill_id INTEGER NOT NULL,
    action_type TEXT NOT NULL,
    action_result TEXT,
    vote_yes INTEGER,
    vote_no INTEGER,
    vote_abstain INTEGER,
    notes TEXT,
    UNIQUE(hearing_id, bill_id, action_type)
);

-- Testimony bill positions
CREATE TABLE IF NOT EXISTS testimony_bill_positions (
    id INTEGER PRIMARY KEY,
    testimony_id INTEGER NOT NULL,
    bill_id INTEGER NOT NULL,
    position TEXT NOT NULL,
    position_summary TEXT,
    UNIQUE(testimony_id, bill_id)
);

-- Eagleton fellows
CREATE TABLE IF NOT EXISTS eagleton_fellows (
    id INTEGER PRIMARY KEY,
    person_id INTEGER NOT NULL,
    fellowship_year TEXT NOT NULL,
    track TEXT,
    placement TEXT,
    placement_department TEXT,
    UNIQUE(person_id, fellowship_year)
);

-- ============================================================
-- STEP 2: Add new columns to existing tables
-- ============================================================

-- Add committee_notice_path to hearings if not exists
-- SQLite doesn't support IF NOT EXISTS for ALTER TABLE, so we use a workaround

-- Check if column exists and add if not (run this in application code)
-- ALTER TABLE hearings ADD COLUMN committee_notice_path TEXT;

-- Add primary_sponsor_id and synopsis to bills
-- ALTER TABLE bills ADD COLUMN primary_sponsor_id INTEGER;
-- ALTER TABLE bills ADD COLUMN synopsis TEXT;

-- Add related_bill_id to claims
-- ALTER TABLE claims ADD COLUMN related_bill_id INTEGER;

-- Add written_testimony_path and testimony_date to testimony
-- ALTER TABLE testimony ADD COLUMN written_testimony_path TEXT;
-- ALTER TABLE testimony ADD COLUMN testimony_date TEXT;

-- ============================================================
-- STEP 3: Migrate witnesses to people
-- ============================================================

INSERT OR IGNORE INTO people (name, title, affiliation, department, expertise_area, person_type)
SELECT name, title, affiliation, department, expertise_area, witness_type
FROM witnesses;

-- ============================================================
-- STEP 4: Create new indexes
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_people_type ON people(person_type);
CREATE INDEX IF NOT EXISTS idx_people_eagleton ON people(is_eagleton_fellow);
CREATE INDEX IF NOT EXISTS idx_testimony_bill_pos ON testimony_bill_positions(testimony_id);
CREATE INDEX IF NOT EXISTS idx_hearing_attendance ON hearing_attendance(hearing_id);

-- ============================================================
-- STEP 5: Create new views
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
LEFT JOIN eagleton_fellows ef ON p.id = ef.person_id
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

-- ============================================================
-- DONE
-- ============================================================
SELECT 'Migration complete. New tables and views created.';
