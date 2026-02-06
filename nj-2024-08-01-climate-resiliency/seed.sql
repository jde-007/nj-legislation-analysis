-- Seed data for NJ Climate Resiliency Hearing Analysis
-- August 1, 2024

-- Hearing metadata
INSERT INTO hearings VALUES (1, '2024-08-01', 
    'Beach Replenishment, Climate Resiliency, and PACT Regulatory Efforts',
    'Toms River Municipal Complex, Toms River, NJ',
    'Senate Environment and Energy Committee; Assembly Environment, Natural Resources, and Solid Waste Committee',
    86, 146522);

-- Committee Members (Senate)
INSERT INTO committee_members VALUES (1, 'Bob Smith', 'Senator', 'Senate', 'Chair', NULL, 'D');
INSERT INTO committee_members VALUES (2, 'Linda R. Greenstein', 'Senator', 'Senate', 'Vice Chair', NULL, 'D');
INSERT INTO committee_members VALUES (3, 'John F. McKeon', 'Senator', 'Senate', 'Member', 'Essex County', 'D');
INSERT INTO committee_members VALUES (4, 'Latham Tiver', 'Senator', 'Senate', 'Member', 'Burlington (4 towns in Atlantic)', 'R');

-- Committee Members (Assembly)
INSERT INTO committee_members VALUES (5, 'James J. Kennedy', 'Assemblyman', 'Assembly', 'Chair', NULL, 'D');
INSERT INTO committee_members VALUES (6, 'Alixon Collazos-Gill', 'Assemblywoman', 'Assembly', 'Member', '27th (Montclair)', 'D');
INSERT INTO committee_members VALUES (7, 'Michael Inganamort', 'Assemblyman', 'Assembly', 'Member', '24th (Morris, Sussex, Warren)', 'R');
INSERT INTO committee_members VALUES (8, 'Gerry Scharfenberger', 'Assemblyman', 'Assembly', 'Member', '13th (Monmouth)', 'R');

-- Speakers
INSERT INTO speakers VALUES (1, 'Nick Angarone', 'Chief Resilience Officer and Manager, Office of Climate Resilience', 
    'New Jersey Department of Environmental Protection', NULL, 'government', 3, 0);
INSERT INTO speakers VALUES (2, 'Lt. Dinan Amin', 'State Hazard Mitigation Officer; Unit Head, Mitigation Unit', 
    'NJ Office of Emergency Management / NJ State Police', NULL, 'government', 26, 0);
INSERT INTO speakers VALUES (3, 'Anthony J. Broccoli', 'Distinguished Professor of Atmospheric Science; Faculty Advisor, NJ Climate Change Resource Center', 
    'Rutgers University', 'Ph.D.', 'scientist', 32, 1);
INSERT INTO speakers VALUES (4, 'Ning Lin', 'Professor, Civil and Environmental Engineering', 
    'Princeton University', 'Ph.D.', 'scientist', 39, 0);
INSERT INTO speakers VALUES (5, 'Lisa Auermuller', 'Administrative Director, Megalopolitan Coastal Transformation Hub', 
    'Rutgers University', NULL, 'policy_expert', 45, 1);
INSERT INTO speakers VALUES (6, 'Kimberly McKenna', 'Interim Executive Director, Coastal Research Center', 
    'Stockton University', NULL, 'scientist', 51, 1);
INSERT INTO speakers VALUES (7, 'Thomas Herrington', 'NY/NJ Vice President', 
    'American Shore and Beach Preservation Association', 'Ph.D.', 'scientist', 56, 0);
INSERT INTO speakers VALUES (8, 'Tim Dillingham', 'Executive Director', 
    'American Littoral Society', NULL, 'advocate', 59, 1);
INSERT INTO speakers VALUES (9, 'Peter Kasabach', 'Executive Director', 
    'New Jersey Future', NULL, 'policy_expert', 73, 0);
INSERT INTO speakers VALUES (10, 'Lindsey Sigmund-Massih', 'Manager, Mainstreaming Green Infrastructure Program', 
    'New Jersey Future', NULL, 'policy_expert', 74, 0);

-- Scientific Claims with exact quotes and page references
-- Dr. Anthony Broccoli (speaker_id=3)
INSERT INTO scientific_claims VALUES (1, 3, 
    'Global temperature rise since late 19th century',
    'Global temperature has risen approximately 2 degrees Fahrenheit since the late 19th century, rising more rapidly in recent decades.',
    32, 'temperature', 'strong', 'NJ Climate Change Resource Center State of the Climate 2023', 'Historical records since 1880', 'global');

INSERT INTO scientific_claims VALUES (2, 3,
    'New Jersey warming rate is double global average',
    'In New Jersey, average annual temperatures have risen by about 4 degrees Fahrenheit since the late 19th century -- so, roughly twice as fast as the global average.',
    33, 'temperature', 'strong', 'State records since 1895', 'State climate monitoring', 'direct_nj');

INSERT INTO scientific_claims VALUES (3, 3,
    'Most warmest years occurred recently',
    'Of the 20 warmest years since 1895, when records began, 15 of them have occurred since 2020, including 2023 -- which, for New Jersey, was the third-warmest year on record.',
    33, 'temperature', 'strong', 'NJ state records', 'Annual temperature records', 'direct_nj');

INSERT INTO scientific_claims VALUES (4, 3,
    'Unusually warm months vastly outnumber cold months',
    'unusually warm months have been much more prevalent than unusually cold months -- outnumbering them 48 to 0 since 1990.',
    33, 'temperature', 'strong', 'State records', 'Monthly extremes analysis', 'direct_nj');

INSERT INTO scientific_claims VALUES (5, 3,
    'Heavy precipitation events increasing significantly',
    'In the northeastern United States, including New Jersey, the number of days on which precipitation of 2 inches or more occurs has increased by 49% since 1958.',
    34, 'precipitation', 'strong', 'NOAA/National Climate Assessment', 'Long-term precipitation monitoring', 'regional');

INSERT INTO scientific_claims VALUES (6, 3,
    'Sea level rise in Atlantic City since 1911',
    'In Atlantic City, sea-levels have risen by more than 18 inches since records began in 1911.',
    34, 'sea_level', 'strong', 'NOAA tide gauge records', 'Continuous tide gauge measurements', 'direct_nj');

INSERT INTO scientific_claims VALUES (7, 3,
    'Sunny-day flooding frequency increase',
    'During the 1950s, that kind of sunny-day flooding in Atlantic City averaged less than one day per year, but that rate had increased to about eight days per year in the decade ending in 2016.',
    35, 'sea_level', 'strong', 'NOAA tidal records', 'High-tide flooding analysis', 'direct_nj');

INSERT INTO scientific_claims VALUES (8, 3,
    'Sea level rise projections through 2100',
    'by 2030 sea-level is expected to rise between 0.5 and 1.1 feet relative to the 1991 to 2009 baseline, and 0.9 to 2.1 feet by 2050... In a moderate emissions scenario, the likely range of sea-level rise in 2100 is expected to be 2.0 to 5.1 feet.',
    35, 'projections', 'strong', 'Rutgers Scientific and Technical Advisory Panel', 'Climate modeling with emissions scenarios', 'direct_nj');

INSERT INTO scientific_claims VALUES (9, 3,
    'Projected sunny-day flooding by 2050',
    'By 2050, sunny-day or nuisance flooding in Atlantic City is projected to occur at least 85 times per year, even with moderate greenhouse gas emissions.',
    35, 'projections', 'strong', 'Rutgers projections', 'Climate-adjusted flood modeling', 'direct_nj');

INSERT INTO scientific_claims VALUES (10, 3,
    'Sandy affected more people due to sea level rise',
    'some of my colleagues at Rutgers have estimated that the rise in sea level since 1880 caused about 38,000 more people in New Jersey to be affected by Hurricane Sandy''s floodwaters.',
    36, 'sea_level', 'strong', 'Rutgers peer-reviewed research', 'Counterfactual flood modeling', 'direct_nj');

INSERT INTO scientific_claims VALUES (11, 3,
    'High confidence in increased coastal flooding',
    'There is high confidence that coastal flooding from future storms will be more frequent and more severe as rising sea levels raise the baseline for such flooding events.',
    36, 'projections', 'strong', 'Scientific consensus/IPCC', 'Multi-model synthesis', 'regional');

INSERT INTO scientific_claims VALUES (12, 3,
    'Hurricanes becoming stronger and wetter',
    'There is good evidence that a warming climate will make hurricanes stronger and wetter; whether they will change in frequency remains uncertain.',
    36, 'storms', 'strong', 'Climate science literature', 'Tropical cyclone modeling', 'regional');

-- Dr. Ning Lin (speaker_id=4)
INSERT INTO scientific_claims VALUES (13, 4,
    '100-year flood becoming more frequent',
    'storm-climatology change and sea-level rise would make the storm-surge flooding risk for this region, specifically New York City, 100-year flood level to occur every three to 20 years, by the end of the century, and a 500-year flood level to occur every 25 to 240 years by the end of the century.',
    40, 'projections', 'strong', 'Nature Climate Change (Feb 2012)', 'Princeton storm surge modeling', 'regional');

INSERT INTO scientific_claims VALUES (14, 4,
    'Hurricane blackouts cause largest US power failures',
    'nine out of 10 largest blackouts in the United States -- caused by hurricanes.',
    43, 'storms', 'strong', 'US power grid data', 'Historical blackout analysis', 'national');

INSERT INTO scientific_claims VALUES (15, 4,
    'Compound hazards from hurricane-blackout-heatwave',
    'What happens if we have heat waves when we lost the power and air conditioning? So, this so-called "hurricane blackout heatwave compound hazards" are emerging.',
    43, 'storms', 'moderate', 'Recent events (Laura 2020, Ida 2021, Beryl 2024)', 'Event analysis', 'regional');

-- Nick Angarone (speaker_id=1)
INSERT INTO scientific_claims VALUES (16, 1,
    'NJ ranks third in nation for FEMA flood claims',
    'as of 2019, New Jersey ranked third in the nation in claims paid by FEMA since 1978... with $5.8 billion in total flood insurance claims.',
    5, 'economic', 'strong', 'FEMA National Flood Insurance Program', 'Claims records', 'direct_nj');

INSERT INTO scientific_claims VALUES (17, 1,
    'Ida flooding occurred outside FEMA flood zones',
    'over 30% of claims from Ida originating outside of FEMA''s designated flood plains.',
    5, 'precipitation', 'strong', 'FEMA Ida claims data', 'Claims mapping analysis', 'direct_nj');

INSERT INTO scientific_claims VALUES (18, 1,
    'Sea level rise projection by 2050',
    'It is likely that sea-level rise will meet or exceed 2.1 feet by 2050.',
    7, 'projections', 'strong', 'Rutgers-based NJ State projections', 'Climate modeling', 'direct_nj');

INSERT INTO scientific_claims VALUES (19, 1,
    'Daily flooding probability in Atlantic City by 2100',
    'a 50% chance that Atlantic City will experience flooding almost every day by 2100.',
    7, 'projections', 'strong', 'NOAA projections', 'Sea level rise scenarios', 'direct_nj');

INSERT INTO scientific_claims VALUES (20, 1,
    'NJ is third-fastest warming state',
    'New Jersey is the third-fastest warming state in the nation.',
    11, 'temperature', 'strong', 'State climate rankings', 'Multi-state temperature trend analysis', 'direct_nj');

INSERT INTO scientific_claims VALUES (21, 1,
    '2024 record-breaking conditions',
    '2024 has been a year marked by the world''s hottest day in recorded history; the first category 4 hurricane to ever form in the Atlantic during the month of June; and a National Weather Service Prediction of 17 to 25 named storms this hurricane season.',
    4, 'temperature', 'strong', 'National Weather Service', 'Real-time monitoring', 'global');

INSERT INTO scientific_claims VALUES (22, 1,
    '12 consecutive months of record high temperatures',
    'We just came through the hottest June ever and have had 12 straight months of record high temperatures. The ocean has now broken temperature records for more than a year.',
    4, 'temperature', 'strong', 'Global climate monitoring', 'Temperature records', 'global');

-- Lt. Dinan Amin (speaker_id=2)
INSERT INTO scientific_claims VALUES (23, 2,
    'NJ experienced 1000-year rainfall and EF3 tornado',
    'Recently, New Jersey''s experienced uncommon hazards such as a 1,000-year, six-hour rainfall total, and an Enhanced Fujita Scale EF3 tornado.',
    27, 'precipitation', 'strong', 'NJOEM records', 'Event documentation', 'direct_nj');

INSERT INTO scientific_claims VALUES (24, 2,
    'Coastal economy generates $60+ billion annually',
    'New Jersey''s coastal economy generates over $60 billion per year, thus being a key driver of New Jersey''s diverse economy.',
    27, 'economic', 'strong', 'State economic data', 'Economic impact analysis', 'direct_nj');

INSERT INTO scientific_claims VALUES (25, 2,
    'Federal funding obtained since Sandy',
    'The Mitigation Unit has obtained more than $1.1 billion in Federal funding since Hurricane Sandy.',
    30, 'economic', 'strong', 'NJOEM grant records', 'Federal grant tracking', 'direct_nj');

-- Kimberly McKenna (speaker_id=6)
INSERT INTO scientific_claims VALUES (26, 6,
    'Sea level rise at Sandy Hook and Atlantic City since 1986',
    'From the tide-gauge records at Sandy Hook and Atlantic City, relative sea level has risen about a half a foot since we started collecting data in 1986.',
    52, 'sea_level', 'strong', 'NOAA tide gauges', 'Continuous tide gauge monitoring', 'direct_nj');

INSERT INTO scientific_claims VALUES (27, 6,
    'Sandy caused 14 million cubic yards of sediment loss',
    'Hurricane Sandy''s losses at the New Jersey Beach Profile Network locations were significant. We saw... losses of 14 million cubic yards of sediment just at our sites that we had monitored.',
    52, 'storms', 'strong', 'NJ Beach Profile Network', 'Beach profile measurements', 'direct_nj');

INSERT INTO scientific_claims VALUES (28, 6,
    'Post-Sandy beach replenishment volume',
    'This allowed the U.S. Army Corps of Engineers to fund placement of over 39 million cubic yards of sand along 113 miles of authorized project shorelines between 2013 and 2019.',
    53, 'economic', 'strong', 'Army Corps records', 'Project documentation', 'direct_nj');

INSERT INTO scientific_claims VALUES (29, 6,
    'Engineered dunes effective in Sandy',
    'beaches with Federally designed coastal risk-reduction projects -- those are the beach nourishment that have the engineered dunes -- these were extremely effective in protecting infrastructure and homes, mostly due to the wide beaches and the high dunes that were created in excess of 20 feet.',
    52, 'storms', 'strong', 'CRC post-Sandy analysis', 'Damage assessment comparison', 'direct_nj');

-- Dr. Thomas Herrington (speaker_id=7)
INSERT INTO scientific_claims VALUES (30, 7,
    'Beach nourishment saved $1.3 billion during Sandy',
    'the U.S. Army Corps determined that beach nourishment projects in New York and New Jersey saved an estimated $1.3 billion in avoided damages.',
    57, 'economic', 'strong', 'U.S. Army Corps of Engineers', 'Damage avoidance calculation', 'regional');

INSERT INTO scientific_claims VALUES (31, 7,
    'NJ coastal tourism economic impact',
    'According to the New Jersey Division of Travel and Tourism, tourism in New Jersey generates over $49 billion in revenue annually, and $29 billion is attributed to the coastal counties.',
    58, 'economic', 'strong', 'NJ Division of Travel and Tourism', 'Economic surveys', 'direct_nj');

INSERT INTO scientific_claims VALUES (32, 7,
    'Beach tourism national statistics',
    'Annually, beach tourism in New Jersey -- in the U.S. -- generates $520 billion in economic output; $240 billion in direct spending; and $36 billion in taxes to Federal, State, and local governments.',
    58, 'economic', 'strong', 'National tourism statistics', 'Economic impact analysis', 'national');

-- Lisa Auermuller (speaker_id=5)
INSERT INTO scientific_claims VALUES (33, 5,
    'Impact of 5 feet inundation on NJ properties',
    '5 feet of permanent inundation would mean... more than 123,000 residential properties and about $27 billion in property value.',
    47, 'projections', 'strong', 'NJ ADAPT platform analysis', 'GIS-based property analysis', 'direct_nj');

INSERT INTO scientific_claims VALUES (34, 5,
    'NJ FloodMapper user statistics',
    'Our NJ FloodMapper tool alone has about 60,000 users annually.',
    47, 'economic', 'strong', 'Rutgers web analytics', 'Usage tracking', 'direct_nj');

-- Tim Dillingham (speaker_id=8)
INSERT INTO scientific_claims VALUES (35, 8,
    'Over 50% of tidal wetlands lost since European settlement',
    'We have filled, over time, more than 50% of the natural base of tidal wetlands that existed when Europeans first got here.',
    68, 'sea_level', 'moderate', 'Historical wetlands mapping', 'GIS comparison studies', 'direct_nj');

-- Legislative Items
INSERT INTO legislative_items VALUES (1, 'pending_rule', 'NJ PACT REAL Rules', 
    'Resilient Environments and Landscapes - updates coastal zone management rules to account for sea-level rise, requires climate-adjusted flood elevation (FEMA 1% storm + 5ft sea level rise)',
    'Pending formal proposal', 'Nick Angarone, Lindsey Sigmund-Massih', 6);

INSERT INTO legislative_items VALUES (2, 'existing_law', 'Inland Flood Protection Rule',
    'Amendment to State flood rules based on more recent NJ-specific rainfall data, updating building and stormwater design standards',
    'Adopted 2023', 'Nick Angarone', 6);

INSERT INTO legislative_items VALUES (3, 'existing_law', 'Flood Disclosure Law',
    'Requires sellers to disclose flood history, DEP to provide online mapping tool at flooddisclosure.nj.gov',
    'Enacted', 'Nick Angarone, Senator Smith', 10);

INSERT INTO legislative_items VALUES (4, 'program', 'Blue Acres Program',
    'Voluntary buyout program for flood-prone properties, over 1,100 properties purchased since 1995',
    'Active', 'Nick Angarone, Lt. Amin', 9);

INSERT INTO legislative_items VALUES (5, 'existing_law', 'Shore Protection Fund',
    'Established 1992, allows NJ to leverage Federal dollars for beach/dune restoration',
    'Active - funding needs increasing', 'Dr. Herrington', 57);

INSERT INTO legislative_items VALUES (6, 'pending_bill', 'Climate Change Cost Recovery',
    'Vermont-style legislation to hold fossil fuel companies responsible for funding resiliency projects',
    'Under consideration', 'Senator McKeon', 17);

INSERT INTO legislative_items VALUES (7, 'recommendation', 'Stormwater Utilities',
    'Legal in NJ with DEP guidelines, only 1 municipality using them, 1,500 exist nationwide',
    'Available tool', 'Senator Smith', 24);

INSERT INTO legislative_items VALUES (8, 'existing_law', 'Master Plan Climate Element',
    'Requires sustainability and resilience elements in municipal master plans every 10 years',
    'Enacted', 'Senator Smith', 24);

INSERT INTO legislative_items VALUES (9, 'program', 'Resilient NJ Program',
    'DEP local planning assistance program, worked with over 40 municipalities',
    'Active', 'Nick Angarone', 12);

INSERT INTO legislative_items VALUES (10, 'recommendation', 'Water Infrastructure Center',
    'Academic institution-based center to examine water and climate issues (Senator Greenstein bill)',
    'Pending', 'Peter Kasabach', 83);

INSERT INTO legislative_items VALUES (11, 'program', 'Extreme Heat Resilience Action Plan',
    '135 specific actions for state agencies, third such plan in the nation',
    'Released July 2024', 'Nick Angarone', 11);

INSERT INTO legislative_items VALUES (12, 'existing_law', 'Executive Order 100',
    'Governor directive to DEP to develop regulations for GHG mitigation and climate resilience',
    '2020 - partial implementation', 'Senator McKeon', 18);

INSERT INTO legislative_items VALUES (13, 'funding', 'NOAA Climate Resilience Regional Challenge',
    '$72 million award to DEP for Building a Climate-Ready NJ initiative',
    'Awarded July 2024', 'Nick Angarone', 12);

-- Link claims to legislation
INSERT INTO claim_legislation_links VALUES (1, 8, 1, 'supports');
INSERT INTO claim_legislation_links VALUES (2, 18, 1, 'supports');
INSERT INTO claim_legislation_links VALUES (3, 19, 1, 'supports');
INSERT INTO claim_legislation_links VALUES (4, 33, 1, 'supports');
INSERT INTO claim_legislation_links VALUES (5, 5, 2, 'supports');
INSERT INTO claim_legislation_links VALUES (6, 17, 2, 'supports');
INSERT INTO claim_legislation_links VALUES (7, 16, 3, 'supports');
INSERT INTO claim_legislation_links VALUES (8, 17, 4, 'supports');
INSERT INTO claim_legislation_links VALUES (9, 30, 5, 'supports');
INSERT INTO claim_legislation_links VALUES (10, 29, 5, 'supports');
INSERT INTO claim_legislation_links VALUES (11, 20, 11, 'supports');

-- Questions and engagement tracking
INSERT INTO questions_engagement VALUES (1, 'Assemblyman Inganamort', 1, 'Certainty of sea level projections', 21);
INSERT INTO questions_engagement VALUES (2, 'Senator McKeon', 1, 'PACT implementation progress', 18);
INSERT INTO questions_engagement VALUES (3, 'Assemblyman Scharfenberger', 1, 'Property value impacts', 19);
INSERT INTO questions_engagement VALUES (4, 'Senator Smith', 3, 'Practical steps for adaptation', 38);
INSERT INTO questions_engagement VALUES (5, 'Senator Greenstein', 3, 'Shore development guidance', 38);
INSERT INTO questions_engagement VALUES (6, 'Senator Smith', 4, 'Coordination with state agencies', 44);
INSERT INTO questions_engagement VALUES (7, 'Senator Smith', 6, 'Beach replenishment priorities', 54);
INSERT INTO questions_engagement VALUES (8, 'Assemblyman Inganamort', 6, 'Engineered dunes success data', 54);
INSERT INTO questions_engagement VALUES (9, 'Assemblyman Inganamort', 8, 'Development obligations impact', 69);
INSERT INTO questions_engagement VALUES (10, 'Senator McKeon', 8, 'Horseshoe crab protection', 72);
INSERT INTO questions_engagement VALUES (11, 'Senator Smith', 9, 'Affordable housing creativity', 80);
