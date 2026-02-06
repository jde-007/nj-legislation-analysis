-- Insert the hearing
INSERT INTO hearings (hearing_date, title, committees, location, topic, transcript_path)
VALUES (
    '2024-04-22',
    'Joint Hearing on Plastic Pollution',
    'Senate Environment and Energy Committee, Assembly Environment Natural Resources and Solid Waste Committee',
    'Committee Room 4, State House Annex, Trenton, New Jersey',
    'The extent of plastic pollution in the State, its potential and actual effects on human health, and methods that may be used to protect against, or to mitigate, the negative effects of plastic pollution on human health and the environment',
    'plastic-pollution-hearing-2024-04-22.pdf'
);

-- Insert committee members present
INSERT INTO committee_members (hearing_id, name, chamber, role, party) VALUES
(1, 'Bob Smith', 'Senate', 'Chair', 'Democrat'),
(1, 'Linda R. Greenstein', 'Senate', 'Vice Chair', 'Democrat'),
(1, 'James J. Kennedy', 'Assembly', 'Chair', 'Democrat'),
(1, 'Shavonda E. Sumter', 'Assembly', 'Vice Chair', 'Democrat'),
(1, 'Alixon Collazos-Gill', 'Assembly', 'Member', 'Democrat'),
(1, 'Garnet R. Hall', 'Assembly', 'Member', 'Democrat'),
(1, 'Andrea Katz', 'Assembly', 'Member', 'Democrat'),
(1, 'Michael Inganamort', 'Assembly', 'Member', 'Republican');

-- Insert speakers
-- 1. Phoebe Stapleton, Ph.D. (SCIENTIST)
INSERT INTO speakers (full_name, title, organization, credentials, is_scientist, scientific_field, expertise_areas, bio, testimony_type)
VALUES (
    'Phoebe Stapleton, Ph.D.',
    'Associate Professor',
    'Rutgers University, Ernest Mario School of Pharmacy',
    'Ph.D., Department of Pharmacology and Toxicology, Resident Scientist at Environmental and Occupational Health Sciences Institute',
    1,
    'Pharmacology and Toxicology',
    'Micro/nanoplastics, particle inhalation during pregnancy, fetal health impacts, maternal health, next-generation health effects',
    'Her lab research focuses on identifying how particles inhaled during pregnancy may affect an expectant mother, developing fetus, and health of the next generation. Recently involved in landmark study finding large numbers of nanoplastics in bottled water.',
    'oral'
);

-- 2. Gary Sondermeyer (INDUSTRY EXPERT)
INSERT INTO speakers (full_name, title, organization, credentials, is_scientist, scientific_field, expertise_areas, bio, testimony_type)
VALUES (
    'Gary Sondermeyer',
    'Vice President of Operations',
    'Bayshore Family of Companies',
    'Former DEP Assistant Commissioner, 30+ years with NJ DEP, Chair of Sustainable New Jersey, Vice Chair NJ Plastics Advisory Council',
    0,
    NULL,
    'Recycling infrastructure, solid waste management, sustainability policy, state regulations',
    'Major leader in NJ environmental issues with 40+ years in environmental sector. Former DEP Director of Solid Waste and Recycling Programs.',
    'both'
);

-- 3. Judith Enck (POLICY EXPERT)
INSERT INTO speakers (full_name, title, organization, credentials, is_scientist, scientific_field, expertise_areas, bio, testimony_type)
VALUES (
    'Judith Enck',
    'President and Founder',
    'Beyond Plastics, Bennington College',
    'Former EPA Region 2 Regional Administrator (Obama Administration), Senior Fellow and Visiting Faculty at Bennington College',
    0,
    NULL,
    'Plastics policy, environmental regulation, packaging reduction, chemical recycling, bottle bill legislation, environmental justice',
    'Appointed by President Obama to serve at EPA. Founded Beyond Plastics. Author of major report on chemical recycling failures.',
    'oral'
);

-- 4. Shanna H. Swan, Ph.D. (SCIENTIST)
INSERT INTO speakers (full_name, title, organization, credentials, is_scientist, scientific_field, expertise_areas, bio, testimony_type)
VALUES (
    'Shanna H. Swan, Ph.D.',
    'Professor',
    'Icahn School of Medicine at Mount Sinai',
    'Ph.D., Department of Environmental Medicine and Public Health, Senior Scientist',
    1,
    'Environmental Epidemiology',
    'Reproductive health, endocrine disrupting chemicals, phthalates, sperm count decline, fetal development, EDC impacts on human health',
    'Reproductive and environmental epidemiologist. Published landmark 2005 study on Phthalate Syndrome in humans. 2017 worldwide sperm count decline study. Over 20 years researching phthalate impacts.',
    'oral'
);

-- 5. Danielle Fortunato (INDUSTRY, written testimony only)
INSERT INTO speakers (full_name, title, organization, credentials, is_scientist, scientific_field, expertise_areas, bio, testimony_type)
VALUES (
    'Danielle Fortunato',
    'Regional Director, State Government Affairs',
    'Plastics Industry Association',
    NULL,
    0,
    NULL,
    'Plastics industry advocacy, policy',
    'Representing the plastics industry trade association',
    'written'
);

-- 6. George Braddon (INDUSTRY, written testimony only)
INSERT INTO speakers (full_name, title, organization, credentials, is_scientist, scientific_field, expertise_areas, bio, testimony_type)
VALUES (
    'George Braddon',
    'Vice President of Government Affairs',
    'Tekni-Plex',
    NULL,
    0,
    NULL,
    'Plastics manufacturing, packaging',
    'Representing a plastics packaging company',
    'written'
);
