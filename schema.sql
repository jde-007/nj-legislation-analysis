-- NJ Legislative Analysis Database Schema (SQLite)
-- Plastic Pollution Hearing April 22, 2024

-- Hearings table
CREATE TABLE IF NOT EXISTS hearings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    hearing_date TEXT NOT NULL,
    title TEXT NOT NULL,
    committees TEXT,
    location TEXT,
    topic TEXT,
    transcript_path TEXT,
    created_at TEXT DEFAULT (datetime('now'))
);

-- Speakers table
CREATE TABLE IF NOT EXISTS speakers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    title TEXT,
    organization TEXT,
    credentials TEXT,
    is_scientist INTEGER DEFAULT 0,
    scientific_field TEXT,
    expertise_areas TEXT,
    bio TEXT,
    testimony_type TEXT CHECK (testimony_type IN ('oral', 'written', 'both')),
    created_at TEXT DEFAULT (datetime('now'))
);

-- Testimony segments table
CREATE TABLE IF NOT EXISTS testimony_segments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    hearing_id INTEGER REFERENCES hearings(id),
    speaker_id INTEGER REFERENCES speakers(id),
    segment_type TEXT CHECK (segment_type IN ('opening', 'testimony', 'question', 'response', 'closing')),
    page_start INTEGER,
    page_end INTEGER,
    content TEXT NOT NULL,
    key_points TEXT,
    created_at TEXT DEFAULT (datetime('now'))
);

-- Scientific claims made in testimony
CREATE TABLE IF NOT EXISTS scientific_claims (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    testimony_segment_id INTEGER REFERENCES testimony_segments(id),
    speaker_id INTEGER REFERENCES speakers(id),
    claim_text TEXT NOT NULL,
    claim_category TEXT,
    evidence_type TEXT CHECK (evidence_type IN ('peer_reviewed_study', 'government_data', 'industry_data', 'personal_research', 'anecdotal', 'meta_analysis')),
    citations TEXT,
    strength TEXT CHECK (strength IN ('strong', 'moderate', 'weak', 'speculative')),
    created_at TEXT DEFAULT (datetime('now'))
);

-- Legislative outcomes potentially influenced
CREATE TABLE IF NOT EXISTS legislative_outcomes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    hearing_id INTEGER REFERENCES hearings(id),
    bill_number TEXT,
    bill_title TEXT,
    bill_status TEXT,
    introduced_date TEXT,
    last_action_date TEXT,
    sponsors TEXT,
    summary TEXT,
    key_provisions TEXT,
    connection_to_hearing TEXT,
    created_at TEXT DEFAULT (datetime('now'))
);

-- Link table: testimony themes to legislative outcomes
CREATE TABLE IF NOT EXISTS testimony_outcome_links (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    scientific_claim_id INTEGER REFERENCES scientific_claims(id),
    legislative_outcome_id INTEGER REFERENCES legislative_outcomes(id),
    influence_type TEXT CHECK (influence_type IN ('direct_quote', 'paraphrase', 'inspired_provision', 'general_theme')),
    influence_strength TEXT CHECK (influence_strength IN ('strong', 'moderate', 'weak', 'speculative')),
    notes TEXT,
    created_at TEXT DEFAULT (datetime('now'))
);

-- Committee members present
CREATE TABLE IF NOT EXISTS committee_members (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    hearing_id INTEGER REFERENCES hearings(id),
    name TEXT NOT NULL,
    chamber TEXT CHECK (chamber IN ('Senate', 'Assembly')),
    role TEXT,
    party TEXT,
    created_at TEXT DEFAULT (datetime('now'))
);
