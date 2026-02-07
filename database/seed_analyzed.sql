-- Seed data from analyzed hearings
-- 2024-04-22 Plastic Pollution & 2024-08-01 Climate Resiliency

-- ============================================================
-- HEARINGS
-- ============================================================

INSERT INTO hearings (id, date, title, committee, topic, transcript_path, pdf_path, source_url, total_witnesses, scientist_witnesses, analysis_status)
VALUES 
(1, '2024-04-22', 'Plastic Pollution and Health', 'Senate Environment and Energy Committee', 'plastic-pollution',
 'nj-2024-04-22-plastic-pollution/transcript.txt', 
 'nj-2024-04-22-plastic-pollution/plastic-pollution-hearing-2024-04-22.pdf',
 'https://www.njleg.state.nj.us/video/archive',
 12, 3, 'complete'),

(2, '2024-08-01', 'Climate Resiliency', 'Senate Environment and Energy Committee', 'climate-resiliency',
 'nj-2024-08-01-climate-resiliency/transcript.txt',
 'nj-2024-08-01-climate-resiliency/senaen08012024.pdf',
 'https://www.njleg.state.nj.us/video/archive',
 10, 4, 'complete');

-- ============================================================
-- WITNESSES
-- ============================================================

-- Plastic Pollution Scientists
INSERT INTO witnesses (id, name, title, affiliation, department, expertise_area, witness_type)
VALUES
(1, 'Dr. Phoebe Stapleton', 'Associate Professor', 'Rutgers University', 'Department of Pharmacology and Toxicology', 'nanoplastics, cardiovascular toxicology', 'scientist'),
(2, 'Dr. Shanna Swan', 'Professor', 'Icahn School of Medicine at Mount Sinai', 'Environmental Medicine and Public Health', 'phthalates, reproductive health, endocrine disruption', 'scientist'),
(3, 'Dr. Philip Demokritou', 'Professor', 'Rutgers University', 'Environmental and Occupational Health Sciences', 'nanoplastics, exposure science', 'scientist');

-- Climate Resiliency Scientists
INSERT INTO witnesses (id, name, title, affiliation, department, expertise_area, witness_type)
VALUES
(4, 'Dr. Anthony Broccoli', 'Distinguished Professor', 'Rutgers University', 'Department of Environmental Sciences', 'atmospheric science, climate modeling', 'scientist'),
(5, 'Dr. Ning Lin', 'Associate Professor', 'Princeton University', 'Civil and Environmental Engineering', 'storm surge modeling, hurricane risk', 'scientist'),
(6, 'Dr. Thomas Herrington', 'Associate Director', 'Monmouth University Urban Coast Institute', 'Coastal Engineering', 'coastal resilience, beach nourishment', 'scientist'),
(7, 'David Robinson', 'NJ State Climatologist', 'Rutgers University', 'NJ Climate Office', 'NJ climate trends, precipitation patterns', 'scientist');

-- Key Advocates/Other witnesses
INSERT INTO witnesses (id, name, title, affiliation, department, expertise_area, witness_type)
VALUES
(8, 'Jeff Tittel', 'Director', 'Sierra Club NJ Chapter', NULL, 'environmental advocacy', 'advocate'),
(9, 'Ed Potosnak', 'Executive Director', 'NJ League of Conservation Voters', NULL, 'environmental policy', 'advocate');

-- ============================================================
-- TESTIMONY
-- ============================================================

INSERT INTO testimony (id, hearing_id, witness_id, position, summary)
VALUES
-- Plastic hearing
(1, 1, 1, 'informational', 'Presented research on nanoplastics crossing biological barriers including blood-brain barrier'),
(2, 1, 2, 'informational', 'Discussed phthalate impacts on reproductive health and success of CPSIA federal legislation'),
(3, 1, 3, 'informational', 'Presented exposure data on nanoplastics in consumer products'),
-- Climate hearing
(4, 2, 4, 'informational', 'Presented NJ temperature trends and attribution science'),
(5, 2, 5, 'informational', 'Presented storm surge modeling and Sandy analysis'),
(6, 2, 6, 'informational', 'Discussed coastal engineering solutions and economic analysis'),
(7, 2, 7, 'informational', 'Presented NJ precipitation and flooding trend data');

-- ============================================================
-- CLAIMS (Sample from analyzed hearings)
-- ============================================================

-- Dr. Stapleton's claims
INSERT INTO claims (id, testimony_id, claim_text, claim_type, topic_tags, page_reference)
VALUES
(1, 1, 'Nanoplastics can cross the blood-brain barrier', 'empirical', 'nanoplastics,health,neurology', NULL),
(2, 1, 'Nanoplastics have been found in human placental tissue', 'empirical', 'nanoplastics,health,reproduction', NULL),
(3, 1, 'Cardiovascular impacts observed in laboratory studies of nanoplastic exposure', 'empirical', 'nanoplastics,health,cardiovascular', NULL);

-- Dr. Swan's claims  
INSERT INTO claims (id, testimony_id, claim_text, claim_type, topic_tags, page_reference)
VALUES
(4, 2, 'Phthalates are endocrine disruptors affecting human development', 'empirical', 'phthalates,endocrine,health', NULL),
(5, 2, 'CPSIA regulation successfully reduced phthalate exposure in children', 'empirical', 'phthalates,regulation,policy-success', NULL),
(6, 2, 'Ortho-phthalates should be regulated as a class, not individually', 'policy-recommendation', 'phthalates,regulation', NULL),
(7, 2, 'Bisphenols are endocrine disruptors that should be banned from food packaging', 'policy-recommendation', 'bisphenols,endocrine,regulation', NULL);

-- Dr. Broccoli's claims
INSERT INTO claims (id, testimony_id, claim_text, claim_type, topic_tags, page_reference)
VALUES
(8, 4, 'NJ temperatures have increased 3.5°F since 1900', 'empirical', 'temperature,nj-specific,trends', NULL),
(9, 4, 'Rate of warming has accelerated in recent decades', 'empirical', 'temperature,acceleration', NULL),
(10, 4, 'Human activities are the dominant cause of observed warming', 'causal', 'attribution,anthropogenic', NULL);

-- Dr. Lin's claims
INSERT INTO claims (id, testimony_id, claim_text, claim_type, topic_tags, page_reference)
VALUES
(11, 5, 'Storm surge modeling shows increasing risk for NJ coast', 'predictive', 'storm-surge,nj-specific,risk', NULL),
(12, 5, 'Sandy-level events will become more frequent with climate change', 'predictive', 'sandy,frequency,climate-change', NULL),
(13, 5, 'Sea level rise compounds storm surge impacts', 'causal', 'sea-level,storm-surge,compounding', NULL);

-- Dr. Herrington's claims
INSERT INTO claims (id, testimony_id, claim_text, claim_type, topic_tags, page_reference)
VALUES
(14, 6, 'Beach nourishment provides cost-effective storm protection', 'empirical', 'beaches,cost-benefit,protection', NULL),
(15, 6, 'NJ beach investments prevented $1.3B in Sandy damages', 'empirical', 'sandy,nj-specific,economic', NULL),
(16, 6, 'Federal cost-share programs essential for coastal protection', 'policy-recommendation', 'federal,funding,policy', NULL);

-- ============================================================
-- EVIDENCE
-- ============================================================

INSERT INTO evidence (id, claim_id, evidence_text, evidence_type, quality_tier, is_nj_specific)
VALUES
-- Stapleton evidence
(1, 1, 'Peer-reviewed laboratory studies on nanoplastic tissue penetration', 'peer-reviewed', 1, 0),
(2, 2, 'Published studies detecting nanoplastics in human placental samples', 'peer-reviewed', 1, 0),
-- Swan evidence
(3, 4, 'Multiple peer-reviewed studies on phthalate endocrine disruption', 'peer-reviewed', 1, 0),
(4, 5, 'CDC biomonitoring data showing reduced phthalate levels post-CPSIA', 'government-data', 2, 0),
-- Broccoli evidence
(5, 8, 'NJ Climate Office temperature records since 1900', 'government-data', 2, 1),
(6, 10, 'IPCC attribution studies', 'peer-reviewed', 1, 0),
-- Lin evidence
(7, 11, 'Princeton storm surge modeling research', 'peer-reviewed', 1, 0),
(8, 12, 'Published hurricane frequency projections under warming scenarios', 'peer-reviewed', 1, 0),
-- Herrington evidence
(9, 15, 'USACE post-Sandy damage assessment', 'government-data', 2, 1),
(10, 15, 'FEMA claims data for NJ shore communities', 'government-data', 2, 1);

-- ============================================================
-- BILLS
-- ============================================================

INSERT INTO bills (id, bill_number, title, session, introduced_date, primary_sponsor, status, topic, bill_text_path, pdf_path)
VALUES
-- Plastic bills
(1, 'A4367', 'Toxic Packaging Reduction Act', '2024-2025', '2024-05-16', 'Collazos-Gill', 'introduced', 'plastic', 'bill-texts/A4367_I1.txt', 'bill-texts/A4367_I1.pdf'),
(2, 'S4367', 'Toxic Packaging Reduction Act (Senate)', '2024-2025', '2024-05-16', NULL, 'introduced', 'plastic', 'bill-texts/S4367_I1.txt', 'bill-texts/S4367_I1.pdf'),
(3, 'A5338', 'Bag Ban Repeal', '2024-2025', '2024-09-12', 'Inganamort', 'introduced', 'plastic', 'bill-texts/A5338_I1.txt', 'bill-texts/A5338_I1.pdf'),
(4, 'A1481', 'Microplastics in Drinking Water', '2024-2025', NULL, NULL, 'introduced', 'plastic', 'bill-texts/A1481_I1.txt', 'bill-texts/A1481_I1.pdf'),
-- Climate bills
(5, 'A2104', 'Flood Mitigation', '2024-2025', NULL, NULL, 'introduced', 'climate', 'bill-texts/A2104_I1.txt', 'bill-texts/A2104_I1.pdf'),
(6, 'S2104', 'Flood Mitigation (Senate)', '2024-2025', NULL, NULL, 'introduced', 'climate', 'bill-texts/S2104_I1.txt', 'bill-texts/S2104_I1.pdf'),
(7, 'A2324', 'Hazard Mitigation Plans', '2024-2025', NULL, NULL, 'introduced', 'climate', 'bill-texts/A2324_I1.txt', 'bill-texts/A2324_I1.pdf'),
(8, 'A1461', 'Climate Mitigation Financing', '2024-2025', NULL, NULL, 'introduced', 'climate', 'bill-texts/A1461_I1.txt', 'bill-texts/A1461_I1.pdf');

-- ============================================================
-- BILL-HEARING LINKS
-- ============================================================

INSERT INTO bill_hearing_links (bill_id, hearing_id, relationship, days_between)
VALUES
(1, 1, 'post-hearing', 24),   -- A4367 introduced 24 days after plastic hearing
(2, 1, 'post-hearing', 24),   -- S4367
(3, 1, 'post-hearing', 143),  -- A5338 (opposition bill)
(4, 1, 'pre-hearing', NULL),  -- A1481 existed before
(5, 2, 'pre-hearing', NULL),  -- A2104 predates hearing
(6, 2, 'pre-hearing', NULL),
(7, 2, 'pre-hearing', NULL),
(8, 2, 'pre-hearing', NULL);

-- ============================================================
-- TERMINOLOGY TRANSFERS
-- ============================================================

INSERT INTO terminology_transfers (claim_id, bill_id, testimony_term, bill_term, bill_section, transfer_type, confidence, notes)
VALUES
-- Dr. Swan's testimony → A4367
(6, 1, 'ortho-phthalates', 'ortho-phthalates', 'Section 3 definitions', 'TERMINOLOGICAL_TRANSFER', 'high', 'Exact term from Swan testimony appears in bill definitions'),
(7, 1, 'bisphenols', 'bisphenols', 'Section 3 definitions', 'TERMINOLOGICAL_TRANSFER', 'high', 'Exact term from Swan testimony'),
(4, 1, 'endocrine disruptor', 'endocrine disrupting compound', 'Section 3 definitions', 'TERMINOLOGICAL_TRANSFER', 'high', 'Nearly verbatim terminology'),
-- Swan's class-based regulation recommendation
(6, 1, 'regulate as a class', 'class of chemicals', 'Section 4', 'SUBSTANTIVE_ALIGNMENT', 'high', 'Bill adopts class-based approach recommended in testimony');

-- A5338 contradictions
INSERT INTO terminology_transfers (claim_id, bill_id, testimony_term, bill_term, bill_section, transfer_type, confidence, notes)
VALUES
(NULL, 3, 'bag ban working', 'increased waste', 'Findings section', 'EVIDENTIARY_CONTRADICTION', 'high', 'Bill claims opposite of hearing testimony');

-- ============================================================
-- LEGISLATOR ATTENDANCE
-- ============================================================

INSERT INTO legislator_attendance (hearing_id, legislator_name, role, later_sponsored_bill)
VALUES
(1, 'Collazos-Gill', 'member', 1),  -- Later sponsored A4367
(1, 'Inganamort', 'member', 3),     -- Later sponsored opposition bill A5338
(1, 'Smith', 'chair', NULL);

-- ============================================================
-- HEARING METRICS
-- ============================================================

INSERT INTO hearing_metrics (hearing_id, total_claims, strong_evidence_pct, nj_specific_pct, avg_evidence_quality, terminology_transfers, effectiveness_score)
VALUES
(1, 42, 81.0, 15.0, 1.8, 4, 72.8),
(2, 35, 94.0, 45.0, 1.5, 0, 78.5);
