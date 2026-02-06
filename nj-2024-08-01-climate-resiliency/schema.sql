-- NJ Climate Resiliency Hearing Analysis Database
-- August 1, 2024 - Joint Senate Environment & Assembly Environment Committees
-- Created: 2026-02-06

CREATE TABLE IF NOT EXISTS hearings (
    id INTEGER PRIMARY KEY,
    date TEXT NOT NULL,
    title TEXT NOT NULL,
    location TEXT,
    committees TEXT,
    page_count INTEGER,
    transcript_chars INTEGER
);

CREATE TABLE IF NOT EXISTS speakers (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    title TEXT,
    organization TEXT,
    credentials TEXT,  -- PhD, JD, etc.
    speaker_type TEXT, -- scientist, policy_expert, advocate, government
    page_start INTEGER,
    testimony_submitted INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS committee_members (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    title TEXT,
    chamber TEXT,  -- Senate, Assembly
    role TEXT,     -- Chair, Vice Chair, Member
    district TEXT,
    party TEXT
);

CREATE TABLE IF NOT EXISTS scientific_claims (
    id INTEGER PRIMARY KEY,
    speaker_id INTEGER REFERENCES speakers(id),
    claim_text TEXT NOT NULL,
    exact_quote TEXT NOT NULL,
    page_ref INTEGER NOT NULL,
    category TEXT,  -- temperature, sea_level, precipitation, storms, economic, projections
    evidence_grade TEXT,  -- strong, moderate, weak
    data_source TEXT,
    methodology TEXT,
    local_relevance TEXT  -- direct_nj, regional, national, global
);

CREATE TABLE IF NOT EXISTS legislative_items (
    id INTEGER PRIMARY KEY,
    item_type TEXT,  -- existing_law, pending_rule, recommendation, program
    name TEXT NOT NULL,
    description TEXT,
    status TEXT,
    mentioned_by TEXT,
    page_ref INTEGER
);

CREATE TABLE IF NOT EXISTS claim_legislation_links (
    id INTEGER PRIMARY KEY,
    claim_id INTEGER REFERENCES scientific_claims(id),
    legislation_id INTEGER REFERENCES legislative_items(id),
    link_type TEXT  -- supports, informs, contradicts
);

CREATE TABLE IF NOT EXISTS questions_engagement (
    id INTEGER PRIMARY KEY,
    questioner TEXT NOT NULL,
    target_speaker_id INTEGER REFERENCES speakers(id),
    question_topic TEXT,
    page_ref INTEGER
);
