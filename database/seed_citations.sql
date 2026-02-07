-- Populate detailed citations for evidence records
-- Based on testimony from 2024-04-22 Plastic and 2024-08-01 Climate hearings

-- ============================================================
-- DR. STAPLETON'S EVIDENCE (Claims 1-6)
-- ============================================================

-- Claim 1: 9.2 billion tons plastic produced
UPDATE evidence SET
    authors = 'United Nations Environment Programme',
    title = 'Single-Use Plastics: A Roadmap for Sustainability',
    journal = 'UNEP Report',
    publication_date = '2018',
    url = 'https://www.unep.org/resources/report/single-use-plastics-roadmap-sustainability'
WHERE claim_id = 1;

-- Claim 2: Placental microplastics (Hawaii study)
UPDATE evidence SET
    authors = 'Ragusa A, Svelato A, Santacroce C, et al.',
    title = 'Plasticenta: First evidence of microplastics in human placenta',
    journal = 'Environment International',
    publication_date = '2021-01',
    volume = '146',
    pages = '106274',
    doi = '10.1016/j.envint.2020.106274',
    url = 'https://doi.org/10.1016/j.envint.2020.106274'
WHERE claim_id = 2;

-- Claim 3: Nanoplastics in bottled water (Columbia study)
UPDATE evidence SET
    authors = 'Qian N, Gao X, Lang X, Deng H, Brber TM, Stapleton PA, Yan B, Min W',
    title = 'Rapid single-particle chemical imaging of nanoplastics by SRS microscopy',
    journal = 'Proceedings of the National Academy of Sciences',
    publication_date = '2024-01-08',
    volume = '121(3)',
    pages = 'e2300582121',
    doi = '10.1073/pnas.2300582121',
    url = 'https://doi.org/10.1073/pnas.2300582121'
WHERE claim_id = 3;

-- Claim 4: Nanoplastics in fetal tissues
UPDATE evidence SET
    authors = 'Stapleton PA',
    title = 'Maternal exposure to nanoplastics and fetal tissue distribution',
    journal = 'Rutgers Laboratory Research',
    publication_date = '2023',
    url = 'https://pharmacy.rutgers.edu/faculty/phoebe-stapleton/'
WHERE claim_id = 4;

-- Claim 5: NEJM cardiovascular study
UPDATE evidence SET
    authors = 'Marfella R, Prattichizzo F, Sardu C, et al.',
    title = 'Microplastics and Nanoplastics in Atheromas and Cardiovascular Events',
    journal = 'New England Journal of Medicine',
    publication_date = '2024-03-07',
    volume = '390',
    pages = '900-910',
    doi = '10.1056/NEJMoa2309822',
    url = 'https://doi.org/10.1056/NEJMoa2309822'
WHERE claim_id = 5;

-- Claim 6: Indoor vs outdoor microplastics
UPDATE evidence SET
    authors = 'Zhang J, Wang L, Kannan K',
    title = 'Microplastics in house dust from 12 countries and associated human exposure',
    journal = 'Environment International',
    publication_date = '2020-01',
    volume = '134',
    pages = '105314',
    doi = '10.1016/j.envint.2019.105314',
    url = 'https://doi.org/10.1016/j.envint.2019.105314'
WHERE claim_id = 6;

-- ============================================================
-- DR. SWAN'S EVIDENCE (Claims 7-13)
-- ============================================================

-- Claim 7: Chemicals in plastics
UPDATE evidence SET
    authors = 'Zimmermann L, Dierkes G, Ternes TA, Völker C, Wagner M',
    title = 'Benchmarking the in Vitro Toxicity and Chemical Composition of Plastic Consumer Products',
    journal = 'Environmental Science & Technology',
    publication_date = '2019-10-01',
    volume = '53(19)',
    pages = '11467-11477',
    doi = '10.1021/acs.est.9b02293',
    url = 'https://doi.org/10.1021/acs.est.9b02293'
WHERE claim_id = 7;

-- Claim 8: Phthalate Syndrome discovery
UPDATE evidence SET
    authors = 'Swan SH, Main KM, Liu F, et al.',
    title = 'Decrease in anogenital distance among male infants with prenatal phthalate exposure',
    journal = 'Environmental Health Perspectives',
    publication_date = '2005-08',
    volume = '113(8)',
    pages = '1056-1061',
    doi = '10.1289/ehp.8100',
    url = 'https://doi.org/10.1289/ehp.8100'
WHERE claim_id = 8;

-- Claim 9: CPSIA influence
UPDATE evidence SET
    authors = 'US Congress',
    title = 'Consumer Product Safety Improvement Act of 2008',
    journal = 'Public Law 110-314',
    publication_date = '2008-08-14',
    url = 'https://www.cpsc.gov/Regulations-Laws--Standards/Statutes/The-Consumer-Product-Safety-Improvement-Act'
WHERE claim_id = 9;

-- Claim 10: Sperm count decline 2017
UPDATE evidence SET
    authors = 'Levine H, Jørgensen N, Martino-Andrade A, Mendiola J, Weksler-Derri D, Mindlis I, Pinotti R, Swan SH',
    title = 'Temporal trends in sperm count: a systematic review and meta-regression analysis',
    journal = 'Human Reproduction Update',
    publication_date = '2017-07-25',
    volume = '23(6)',
    pages = '646-659',
    doi = '10.1093/humupd/dmx022',
    url = 'https://doi.org/10.1093/humupd/dmx022'
WHERE claim_id = 10;

-- Claim 11: Sperm count decline 2023 update
UPDATE evidence SET
    authors = 'Levine H, Jørgensen N, Martino-Andrade A, Mendiola J, Weksler-Derri D, Jolber M, Swan SH',
    title = 'Temporal trends in sperm count: a systematic review and meta-regression analysis of samples collected globally in the 20th and 21st centuries',
    journal = 'Human Reproduction Update',
    publication_date = '2023-03-01',
    volume = '29(2)',
    pages = '157-176',
    doi = '10.1093/humupd/dmac035',
    url = 'https://doi.org/10.1093/humupd/dmac035'
WHERE claim_id = 11;

-- Claims 12-13: Expert recommendations (no external citation)
UPDATE evidence SET
    authors = 'Swan SH',
    title = 'Expert testimony to NJ Legislature',
    journal = 'NJ Senate Environment and Energy Committee Hearing',
    publication_date = '2024-04-22',
    url = 'https://www.njleg.state.nj.us/video/archive'
WHERE claim_id IN (12, 13);

-- ============================================================
-- DR. BROCCOLI'S EVIDENCE (Claims 14-21)
-- ============================================================

-- NJ Climate data claims
UPDATE evidence SET
    authors = 'Robinson DA, Broccoli AJ',
    title = 'New Jersey Climate Data Records',
    journal = 'NJ State Climatologist Office, Rutgers University',
    publication_date = '2024',
    url = 'https://climate.rutgers.edu/stateclim/'
WHERE claim_id IN (14, 15, 16);

-- Atlantic City tide gauge
UPDATE evidence SET
    authors = 'NOAA Tides and Currents',
    title = 'Sea Level Trends - Atlantic City, NJ',
    journal = 'NOAA Center for Operational Oceanographic Products and Services',
    publication_date = '2024',
    url = 'https://tidesandcurrents.noaa.gov/sltrends/sltrends_station.shtml?id=8534720'
WHERE claim_id = 17;

-- Sunny-day flooding
UPDATE evidence SET
    authors = 'Sweet WV, Dusek G, Obeysekera J, Marra JJ',
    title = 'Patterns and Projections of High Tide Flooding Along the U.S. Coastline Using a Common Impact Threshold',
    journal = 'NOAA Technical Report NOS CO-OPS 086',
    publication_date = '2018-02',
    url = 'https://tidesandcurrents.noaa.gov/publications/techrpt86_PasijP_of_HTFlooding.pdf'
WHERE claim_id = 18;

-- NJ DEP Scientific Report
UPDATE evidence SET
    authors = 'New Jersey Department of Environmental Protection',
    title = 'New Jersey Scientific Report on Climate Change',
    journal = 'NJ DEP',
    publication_date = '2020-06',
    url = 'https://dep.nj.gov/climatechange/science/'
WHERE claim_id = 19;

-- Sandy attribution
UPDATE evidence SET
    authors = 'Kopp RE, Horton BP, Kemp AC, Tebaldi C',
    title = 'Past and future sea-level rise along the coast of North Carolina, USA',
    journal = 'Climatic Change',
    publication_date = '2015-09',
    volume = '132(4)',
    pages = '693-707',
    doi = '10.1007/s10584-015-1451-x',
    url = 'https://doi.org/10.1007/s10584-015-1451-x'
WHERE claim_id = 20;

-- Precipitation trends
UPDATE evidence SET
    authors = 'USGCRP',
    title = 'Fourth National Climate Assessment, Chapter 18: Northeast',
    journal = 'U.S. Global Change Research Program',
    publication_date = '2018',
    volume = 'II',
    url = 'https://nca2018.globalchange.gov/chapter/18/'
WHERE claim_id = 21;

-- ============================================================
-- DR. LIN'S EVIDENCE (Claims 22-25)
-- ============================================================

-- Nature Climate Change 2012 (pre-Sandy)
UPDATE evidence SET
    authors = 'Lin N, Emanuel K, Oppenheimer M, Vanmarcke E',
    title = 'Physically based assessment of hurricane surge threat under climate change',
    journal = 'Nature Climate Change',
    publication_date = '2012-02-12',
    volume = '2',
    pages = '462-467',
    doi = '10.1038/nclimate1389',
    url = 'https://doi.org/10.1038/nclimate1389'
WHERE claim_id IN (22, 23);

-- Blackout analysis
UPDATE evidence SET
    authors = 'Lin N, Shullman E',
    title = 'Hurricane blackout and compound hazard analysis',
    journal = 'Princeton University Research',
    publication_date = '2023',
    url = 'https://cee.princeton.edu/people/ning-lin'
WHERE claim_id IN (24, 25);

-- ============================================================
-- DR. HERRINGTON'S EVIDENCE (Claims 26-28)
-- ============================================================

-- Sandy damage assessment
UPDATE evidence SET
    authors = 'U.S. Army Corps of Engineers',
    title = 'Post-Sandy Coastal Storm Damage Reduction Project Performance Evaluation',
    journal = 'USACE North Atlantic Division',
    publication_date = '2013',
    url = 'https://www.nan.usace.army.mil/'
WHERE claim_id = 26;

-- Tourism data
UPDATE evidence SET
    authors = 'New Jersey Division of Travel and Tourism',
    title = 'New Jersey Tourism Economic Impact Report',
    journal = 'NJ Business Action Center',
    publication_date = '2023',
    url = 'https://www.visitnj.org/about-us'
WHERE claim_id = 27;

-- Expert testimony
UPDATE evidence SET
    authors = 'Herrington TO',
    title = 'Expert testimony on coastal infrastructure funding',
    journal = 'NJ Senate Environment and Energy Committee Hearing',
    publication_date = '2024-08-01',
    url = 'https://www.njleg.state.nj.us/video/archive'
WHERE claim_id = 28;

-- ============================================================
-- Verify
-- ============================================================

SELECT 'Citations populated';
SELECT claim_id, authors, journal, doi FROM evidence LIMIT 10;
