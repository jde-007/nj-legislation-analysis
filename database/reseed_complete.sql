-- Complete reseed of analyzed hearings with full v2 schema data
-- Run after: schema_v2.sql, migrate_v1_to_v2.sql, seed_eagleton_fellows.sql

-- Clear existing data for clean reseed
DELETE FROM claim_bill_positions;
DELETE FROM evidence;
DELETE FROM claims;
DELETE FROM testimony_bill_positions;
DELETE FROM testimony;
DELETE FROM hearing_attendance;
DELETE FROM hearing_committees;
DELETE FROM hearing_bill_actions;
DELETE FROM hearing_agenda_bills;
DELETE FROM bill_hearing_links;
DELETE FROM terminology_transfers;
DELETE FROM hearing_metrics;

-- ============================================================
-- COMMITTEES
-- ============================================================

INSERT OR IGNORE INTO committees (id, name, chamber, committee_type)
VALUES
(1, 'Senate Environment and Energy Committee', 'senate', 'standing'),
(2, 'Assembly Environment, Natural Resources, and Solid Waste Committee', 'assembly', 'standing');

-- ============================================================
-- PEOPLE (Legislators)
-- ============================================================

INSERT OR IGNORE INTO people (name, title, affiliation, person_type, party, district)
VALUES
('Bob Smith', 'Senator', 'NJ Senate', 'legislator', 'D', '17'),
('Linda R. Greenstein', 'Senator', 'NJ Senate', 'legislator', 'D', '14'),
('James J. Kennedy', 'Assemblyman', 'NJ Assembly', 'legislator', 'D', '22'),
('Shavonda E. Sumter', 'Assemblywoman', 'NJ Assembly', 'legislator', 'D', '35'),
('Alixon Collazos-Gill', 'Assemblywoman', 'NJ Assembly', 'legislator', 'D', '27'),
('Garnet R. Hall', 'Assemblyman', 'NJ Assembly', 'legislator', 'D', '28'),
('Andrea Katz', 'Assemblywoman', 'NJ Assembly', 'legislator', 'D', '8'),
('Michael Inganamort', 'Assemblyman', 'NJ Assembly', 'legislator', 'R', '24'),
('Michael Testa', 'Senator', 'NJ Senate', 'legislator', 'R', '1');

-- ============================================================
-- HEARING 1: Plastic Pollution (2024-04-22)
-- ============================================================

UPDATE hearings SET 
    committee_notice_path = 'nj-2024-04-22-plastic-pollution/agenda.pdf',
    scientist_witnesses = 3,
    total_witnesses = 4
WHERE id = 1;

-- Hearing-Committee Links (Joint hearing)
INSERT OR IGNORE INTO hearing_committees (hearing_id, committee_id, role)
VALUES
(1, 1, 'co-host'),  -- Senate Environment
(1, 2, 'co-host');  -- Assembly Environment

-- Hearing Attendance - Legislators
INSERT OR IGNORE INTO hearing_attendance (hearing_id, person_id, role, attendance_type)
SELECT 1, id, 
    CASE name 
        WHEN 'Bob Smith' THEN 'chair'
        WHEN 'Linda R. Greenstein' THEN 'vice-chair'
        WHEN 'James J. Kennedy' THEN 'chair'
        WHEN 'Shavonda E. Sumter' THEN 'vice-chair'
        ELSE 'member'
    END,
    'committee_member'
FROM people 
WHERE name IN ('Bob Smith', 'Linda R. Greenstein', 'James J. Kennedy', 'Shavonda E. Sumter', 
               'Alixon Collazos-Gill', 'Garnet R. Hall', 'Andrea Katz', 'Michael Inganamort');

-- Bills on Agenda for Plastic Hearing
INSERT OR IGNORE INTO hearing_agenda_bills (hearing_id, bill_id, agenda_order, scheduled_action)
VALUES
(1, 1, 1, 'discussion'),  -- A4367 Toxic Packaging
(1, 4, 2, 'discussion');  -- A1481 Microplastics

-- ============================================================
-- HEARING 2: Climate Resiliency (2024-08-01)
-- ============================================================

UPDATE hearings SET 
    committee_notice_path = 'nj-2024-08-01-climate-resiliency/agenda.pdf',
    location = 'Toms River Municipal Complex, Toms River, NJ',
    scientist_witnesses = 4,
    total_witnesses = 10
WHERE id = 2;

-- Hearing-Committee Links
INSERT OR IGNORE INTO hearing_committees (hearing_id, committee_id, role)
VALUES
(2, 1, 'co-host'),
(2, 2, 'co-host');

-- Hearing Attendance - Legislators
INSERT OR IGNORE INTO hearing_attendance (hearing_id, person_id, role, attendance_type)
SELECT 2, id, 
    CASE name 
        WHEN 'Bob Smith' THEN 'chair'
        ELSE 'member'
    END,
    'committee_member'
FROM people 
WHERE name IN ('Bob Smith', 'Michael Testa');

-- Bills on Agenda for Climate Hearing
INSERT OR IGNORE INTO hearing_agenda_bills (hearing_id, bill_id, agenda_order, scheduled_action)
VALUES
(2, 5, 1, 'discussion'),  -- A2104 Flood Mitigation
(2, 7, 2, 'discussion');  -- A2324 Hazard Plans

-- ============================================================
-- SCIENTISTS (as People)
-- ============================================================

INSERT OR IGNORE INTO people (name, title, affiliation, department, expertise_area, person_type)
VALUES
-- Plastic hearing scientists
('Dr. Phoebe Stapleton', 'Associate Professor', 'Rutgers University', 'Department of Pharmacology and Toxicology', 'nanoplastics, cardiovascular toxicology, maternal-fetal health', 'scientist'),
('Dr. Shanna Swan', 'Professor', 'Icahn School of Medicine at Mount Sinai', 'Environmental Medicine and Public Health', 'phthalates, reproductive health, endocrine disruption', 'scientist'),
('Dr. Philip Demokritou', 'Professor', 'Rutgers University', 'Environmental and Occupational Health Sciences', 'nanoplastics, exposure science', 'scientist'),
-- Climate hearing scientists
('Dr. Anthony Broccoli', 'Distinguished Professor', 'Rutgers University', 'Department of Environmental Sciences', 'atmospheric science, climate modeling, NJ climate', 'scientist'),
('Dr. Ning Lin', 'Professor', 'Princeton University', 'Civil and Environmental Engineering', 'storm surge modeling, hurricane risk, compound hazards', 'scientist'),
('Dr. Thomas Herrington', 'Associate Director', 'Monmouth University Urban Coast Institute', 'Coastal Engineering', 'coastal resilience, beach nourishment, ASBPA', 'scientist'),
('David Robinson', 'State Climatologist', 'Rutgers University', 'NJ Climate Office', 'NJ climate trends, precipitation patterns', 'scientist'),
-- Government witnesses
('Nick Angarone', 'Chief Resilience Officer', 'NJ DEP', NULL, 'climate resilience, PACT regulations', 'government'),
('Judith Enck', 'President', 'Beyond Plastics', NULL, 'environmental policy, plastics regulation', 'advocate'),
('Gary Sondermeyer', 'VP Operations', 'Bayshore Family of Companies', NULL, 'recycling infrastructure, solid waste', 'industry');

-- ============================================================
-- TESTIMONY with Bill Positions
-- ============================================================

-- Plastic Hearing Testimony
INSERT INTO testimony (id, hearing_id, witness_id, summary, page_start)
SELECT 101, 1, w.id, 'Presented research on nanoplastics crossing biological barriers, found in placentas and fetal tissues', 1
FROM witnesses w WHERE w.name = 'Dr. Phoebe Stapleton';

INSERT INTO testimony (id, hearing_id, witness_id, summary, page_start)
SELECT 102, 1, w.id, 'Testified on phthalates as endocrine disruptors, reproductive health impacts, success of CPSIA regulation', 52
FROM witnesses w WHERE w.name = 'Dr. Shanna Swan';

-- Climate Hearing Testimony
INSERT INTO testimony (id, hearing_id, witness_id, summary, page_start)
SELECT 103, 2, w.id, 'Presented NJ temperature trends (+4°F since 1895), sea-level rise data (18+ inches in Atlantic City), precipitation increases', 32
FROM witnesses w WHERE w.name = 'Dr. Anthony Broccoli';

INSERT INTO testimony (id, hearing_id, witness_id, summary, page_start)
SELECT 104, 2, w.id, 'Presented storm surge modeling, 100-year flood becoming 3-20 year event, compound hurricane-blackout-heatwave hazards', 39
FROM witnesses w WHERE w.name = 'Dr. Ning Lin';

INSERT INTO testimony (id, hearing_id, witness_id, summary, page_start)
SELECT 105, 2, w.id, 'Testified beach nourishment saved $1.3B in Sandy damages, coastal tourism generates $29B annually', 56
FROM witnesses w WHERE w.name = 'Dr. Thomas Herrington';

-- Testimony Bill Positions
INSERT OR IGNORE INTO testimony_bill_positions (testimony_id, bill_id, position, position_summary)
VALUES
-- Dr. Stapleton - neutral/informational on microplastics testing
(101, 4, 'neutral', 'Provided scientific background on microplastics, no explicit position'),
-- Dr. Swan - strongly FOR toxic packaging reduction
(102, 1, 'for', 'Explicitly supports banning phthalates and bisphenols in packaging'),
-- Climate scientists - FOR flood/resilience legislation
(103, 5, 'for', 'Data supports need for flood mitigation measures'),
(103, 7, 'for', 'Climate projections support updated hazard planning'),
(104, 5, 'for', 'Storm surge modeling supports flood mitigation'),
(105, 5, 'for', 'Beach nourishment cost-effectiveness supports flood mitigation');

-- ============================================================
-- SCIENTIFIC CLAIMS with Bill Positions
-- ============================================================

-- Dr. Stapleton's Claims
INSERT INTO claims (id, testimony_id, claim_text, claim_type, topic_tags, page_reference)
VALUES
(1, 101, '9.2 billion tons of plastic produced 1950-2017', 'empirical', 'plastic,production,scale', NULL),
(2, 101, '100% of Hawaii placental samples contained microplastics in 2021 (up from 60% in 2006)', 'empirical', 'microplastics,health,placenta', NULL),
(3, 101, 'Hundreds of thousands of nanoplastic particles found in bottled water', 'empirical', 'nanoplastics,water,exposure', NULL),
(4, 101, 'Nanoplastics identified in fetal tissues within 24 hours of exposure', 'empirical', 'nanoplastics,fetal,health', NULL),
(5, 101, 'NEJM study: micro/nanoplastics in carotid plaque correlated with cardiovascular risk', 'empirical', 'nanoplastics,cardiovascular,health', NULL),
(6, 101, 'Indoor air microplastic concentrations 100x greater than outdoor', 'empirical', 'microplastics,air,exposure', NULL);

-- Dr. Swan's Claims
INSERT INTO claims (id, testimony_id, claim_text, claim_type, topic_tags, page_reference)
VALUES
(7, 102, '15,000+ chemicals in plastics; 25% classified as chemicals of concern', 'empirical', 'chemicals,plastics,health', NULL),
(8, 102, 'Discovered and replicated Phthalate Syndrome in humans', 'empirical', 'phthalates,reproductive,health', NULL),
(9, 102, 'Research influenced Consumer Product Safety Improvement Act of 2008', 'empirical', 'phthalates,regulation,policy', NULL),
(10, 102, 'Worldwide sperm counts declined 50% since 1970 (~1%/year)', 'empirical', 'fertility,phthalates,health', NULL),
(11, 102, '2023 update: sperm count decline is accelerating, not leveling', 'empirical', 'fertility,trends,health', NULL),
(12, 102, 'Ortho-phthalates should be regulated as a class, not individually', 'policy-recommendation', 'phthalates,regulation', NULL),
(13, 102, 'Bisphenols should be banned from food packaging', 'policy-recommendation', 'bisphenols,regulation,packaging', NULL);

-- Dr. Broccoli's Claims
INSERT INTO claims (id, testimony_id, claim_text, claim_type, topic_tags, page_reference)
VALUES
(14, 103, 'NJ temperatures have risen 4°F since late 19th century - twice the global average', 'empirical', 'temperature,nj-specific,climate', 33),
(15, 103, '15 of 20 warmest years since 1895 have occurred since 2020', 'empirical', 'temperature,nj-specific,trends', 33),
(16, 103, 'Unusually warm months have outnumbered cold months 48 to 0 since 1990', 'empirical', 'temperature,nj-specific,trends', 33),
(17, 103, 'Atlantic City sea levels risen 18+ inches since 1911', 'empirical', 'sea-level,nj-specific,atlantic-city', 34),
(18, 103, 'Sunny-day flooding in Atlantic City increased from <1 day/year (1950s) to 8 days/year (2016)', 'empirical', 'flooding,nj-specific,atlantic-city', 35),
(19, 103, 'By 2050: 85+ sunny-day flooding events per year in Atlantic City projected', 'predictive', 'flooding,nj-specific,projections', 35),
(20, 103, 'Sea level rise since 1880 caused 38,000 more people affected by Sandy', 'causal', 'sandy,sea-level,attribution', 36),
(21, 103, 'NE US precipitation 2+ inch days increased 49% since 1958', 'empirical', 'precipitation,northeast,trends', 34);

-- Dr. Lin's Claims  
INSERT INTO claims (id, testimony_id, claim_text, claim_type, topic_tags, page_reference)
VALUES
(22, 104, '100-year flood will become 3-20 year event by end of century', 'predictive', 'flooding,projections,risk', 40),
(23, 104, '500-year flood will become 25-240 year event by end of century', 'predictive', 'flooding,projections,risk', 41),
(24, 104, '9 of 10 largest US blackouts caused by hurricanes', 'empirical', 'hurricanes,infrastructure,blackouts', 43),
(25, 104, 'Hurricane-blackout-heatwave compound hazards are emerging threat', 'predictive', 'compound-hazards,hurricanes,heatwaves', 43);

-- Dr. Herrington's Claims
INSERT INTO claims (id, testimony_id, claim_text, claim_type, topic_tags, page_reference)
VALUES
(26, 105, 'Beach nourishment saved $1.3 billion in avoided Sandy damages', 'empirical', 'beaches,sandy,economic,nj-specific', 57),
(27, 105, 'NJ coastal tourism generates $29 billion annually', 'empirical', 'tourism,economic,nj-specific', 58),
(28, 105, 'Federal cost-share programs essential for coastal protection', 'policy-recommendation', 'federal,funding,beaches', 58);

-- ============================================================
-- CLAIM-BILL POSITIONS
-- ============================================================

-- Dr. Stapleton's claims - neutral/informational on A1481
INSERT INTO claim_bill_positions (claim_id, bill_id, position, position_notes)
VALUES
(1, 4, 'neutral', 'Background on plastic production scale'),
(2, 4, 'neutral', 'Evidence of microplastic exposure relevant to testing needs'),
(3, 4, 'neutral', 'Evidence of nanoplastics in bottled water'),
(4, 4, 'neutral', 'Health impact evidence'),
(5, 4, 'neutral', 'Cardiovascular health evidence'),
(6, 4, 'neutral', 'Indoor exposure evidence');

-- Dr. Swan's claims - FOR A4367
INSERT INTO claim_bill_positions (claim_id, bill_id, position, position_notes)
VALUES
(7, 1, 'for', 'Supports need to regulate plastic chemicals'),
(8, 1, 'for', 'Phthalate harm supports packaging ban'),
(9, 1, 'for', 'Demonstrates regulation can work'),
(10, 1, 'for', 'Fertility decline supports urgent action'),
(11, 1, 'for', 'Accelerating decline supports urgent action'),
(12, 1, 'for', 'Direct recommendation: regulate ortho-phthalates as class'),
(13, 1, 'for', 'Direct recommendation: ban bisphenols from packaging');

-- Climate scientists' claims - FOR A2104 (Flood Mitigation)
INSERT INTO claim_bill_positions (claim_id, bill_id, position, position_notes)
VALUES
(14, 5, 'for', 'Temperature rise supports climate action'),
(15, 5, 'for', 'Warming trends support mitigation'),
(16, 5, 'for', 'Temperature data supports action'),
(17, 5, 'for', 'Sea level data supports flood mitigation'),
(18, 5, 'for', 'Flooding increase supports mitigation'),
(19, 5, 'for', 'Projections support urgent action'),
(20, 5, 'for', 'Sandy attribution supports mitigation investment'),
(21, 5, 'for', 'Precipitation increase supports flood mitigation'),
(22, 5, 'for', 'Flood risk increase supports mitigation'),
(23, 5, 'for', 'Extreme flood risk supports mitigation'),
(24, 5, 'for', 'Infrastructure vulnerability supports resilience planning'),
(25, 5, 'for', 'Compound hazards support comprehensive planning'),
(26, 5, 'for', 'Beach investment ROI supports continued investment'),
(27, 5, 'for', 'Economic impact supports coastal protection'),
(28, 5, 'for', 'Federal funding recommendation');

-- Climate claims also support A2324 (Hazard Plans)
INSERT INTO claim_bill_positions (claim_id, bill_id, position, position_notes)
VALUES
(14, 7, 'for', 'Temperature data supports updated hazard plans'),
(17, 7, 'for', 'Sea level data supports hazard planning'),
(19, 7, 'for', 'Projections require updated planning'),
(22, 7, 'for', 'Risk increase requires updated plans'),
(25, 7, 'for', 'Compound hazards require updated planning');

-- ============================================================
-- EVIDENCE for Claims
-- ============================================================

-- Stapleton evidence
INSERT INTO evidence (claim_id, evidence_text, evidence_type, quality_tier, is_nj_specific)
VALUES
(1, 'UN Environment Program data', 'government-data', 2, 0),
(2, 'Peer-reviewed longitudinal study comparing 2006 vs 2021', 'peer-reviewed', 1, 0),
(3, 'Own research with Columbia University using specialized microscopy', 'peer-reviewed', 1, 0),
(4, 'Laboratory research using rodent models', 'peer-reviewed', 1, 0),
(5, 'New England Journal of Medicine, March 2024', 'peer-reviewed', 1, 0),
(6, 'Published research on indoor vs outdoor concentrations', 'peer-reviewed', 1, 0);

-- Swan evidence
INSERT INTO evidence (claim_id, evidence_text, evidence_type, quality_tier, is_nj_specific)
VALUES
(7, 'Meta-analysis of published research on plastic chemicals', 'peer-reviewed', 1, 0),
(8, 'NIH-funded research ($10M), replicated in second study', 'peer-reviewed', 1, 0),
(9, 'Congressional testimony record, CPSIA passage documented', 'government-data', 2, 0),
(10, 'Published 2017 meta-analysis on global sperm counts', 'peer-reviewed', 1, 0),
(11, 'Published 2023 update to sperm count research', 'peer-reviewed', 1, 0),
(12, 'Expert recommendation based on research', 'expert-testimony', 3, 0),
(13, 'Expert recommendation based on research', 'expert-testimony', 3, 0);

-- Broccoli evidence (NJ-specific)
INSERT INTO evidence (claim_id, evidence_text, evidence_type, quality_tier, is_nj_specific)
VALUES
(14, 'NJ Climate Office temperature records since 1895', 'government-data', 2, 1),
(15, 'NJ Climate Office records', 'government-data', 2, 1),
(16, 'NJ Climate Office monthly temperature analysis', 'government-data', 2, 1),
(17, 'Atlantic City tide gauge records since 1911', 'government-data', 2, 1),
(18, 'NOAA sunny-day flooding analysis for Atlantic City', 'government-data', 2, 1),
(19, 'NJ DEP 2020 Scientific Report on Climate Change', 'government-data', 2, 1),
(20, 'Rutgers colleague research on Sandy attribution', 'peer-reviewed', 1, 1),
(21, 'NOAA precipitation records for Northeast US', 'government-data', 2, 0);

-- Lin evidence
INSERT INTO evidence (claim_id, evidence_text, evidence_type, quality_tier, is_nj_specific)
VALUES
(22, 'Nature Climate Change 2012 paper (published before Sandy)', 'peer-reviewed', 1, 0),
(23, 'Nature Climate Change 2012 paper', 'peer-reviewed', 1, 0),
(24, 'Analysis of major US power outages', 'peer-reviewed', 1, 0),
(25, 'Emerging research on compound hazards', 'peer-reviewed', 1, 0);

-- Herrington evidence (NJ-specific)
INSERT INTO evidence (claim_id, evidence_text, evidence_type, quality_tier, is_nj_specific)
VALUES
(26, 'US Army Corps post-Sandy damage assessment', 'government-data', 2, 1),
(27, 'NJ Division of Travel and Tourism data', 'government-data', 2, 1),
(28, 'Expert testimony on federal cost-share programs', 'expert-testimony', 3, 0);

-- ============================================================
-- TERMINOLOGY TRANSFERS
-- ============================================================

-- Swan testimony → A4367
INSERT INTO terminology_transfers (claim_id, bill_id, testimony_term, bill_term, bill_section, transfer_type, confidence)
VALUES
(12, 1, 'ortho-phthalates', 'ortho-phthalates', 'Section 3 definitions', 'TERMINOLOGICAL_TRANSFER', 'high'),
(13, 1, 'bisphenols', 'bisphenols', 'Section 3 definitions', 'TERMINOLOGICAL_TRANSFER', 'high'),
(8, 1, 'endocrine disruptor', 'endocrine disrupting compound', 'Section 3 definitions', 'TERMINOLOGICAL_TRANSFER', 'high'),
(12, 1, 'regulate as a class', 'class of chemicals', 'Section 4', 'SUBSTANTIVE_ALIGNMENT', 'high');

-- A5338 contradiction (bag ban repeal contradicts testimony)
INSERT INTO terminology_transfers (claim_id, bill_id, testimony_term, bill_term, bill_section, transfer_type, confidence, notes)
VALUES
(NULL, 3, 'bag ban working', 'increased waste', 'Findings section', 'EVIDENTIARY_CONTRADICTION', 'high', 'Bill claims opposite of environmental testimony');

-- ============================================================
-- BILL-HEARING LINKS
-- ============================================================

INSERT OR IGNORE INTO bill_hearing_links (bill_id, hearing_id, relationship, days_between)
VALUES
(1, 1, 'post-hearing', 24),   -- A4367 introduced 24 days after plastic hearing
(2, 1, 'post-hearing', 24),   -- S4367
(3, 1, 'post-hearing', 143),  -- A5338 (opposition bill)
(4, 1, 'discussed', NULL),    -- A1481 discussed at hearing
(5, 2, 'discussed', NULL),    -- A2104 discussed at climate hearing
(7, 2, 'discussed', NULL);    -- A2324 discussed at climate hearing

-- ============================================================
-- HEARING METRICS
-- ============================================================

INSERT OR REPLACE INTO hearing_metrics (hearing_id, total_claims, strong_evidence_pct, nj_specific_pct, avg_evidence_quality, terminology_transfers, effectiveness_score)
VALUES
(1, 13, 84.6, 0.0, 1.5, 4, 72.8),
(2, 15, 93.3, 73.3, 1.8, 0, 78.5);

-- ============================================================
-- Verify
-- ============================================================

SELECT 'Reseed complete';
SELECT 'Claims: ' || COUNT(*) FROM claims;
SELECT 'Claim-bill positions: ' || COUNT(*) FROM claim_bill_positions;
SELECT 'Evidence: ' || COUNT(*) FROM evidence;
SELECT 'Testimony: ' || COUNT(*) FROM testimony;
SELECT 'Testimony-bill positions: ' || COUNT(*) FROM testimony_bill_positions;
