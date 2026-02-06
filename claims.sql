-- Scientific claims from Dr. Phoebe Stapleton (Speaker ID 1)
INSERT INTO scientific_claims (speaker_id, claim_text, claim_category, evidence_type, citations, strength) VALUES
(1, '9.2 billion tons of plastic produced between 1950 and 2017', 'production_scale', 'government_data', 'United Nations Environment Program', 'strong'),
(1, '400 million tons of plastics produced per year in 2022, estimated to reach 590 million tons by 2050', 'production_scale', 'government_data', 'UN estimates', 'strong'),
(1, 'Microplastics found in Raritan and Passaic rivers in NJ; stormwater identified as primary contributor', 'environmental_presence', 'peer_reviewed_study', 'Rutgers University studies', 'strong'),
(1, 'Indoor air can have microplastic concentrations 100 times greater than outdoor air', 'exposure_pathways', 'peer_reviewed_study', NULL, 'moderate'),
(1, 'Collaborative study with Columbia University found hundreds of thousands of nanoplastic particles in three brands of bottled water', 'exposure_pathways', 'peer_reviewed_study', 'Columbia University collaboration using specialized microscopy', 'strong'),
(1, 'Nanoplastics in bottled water not derived from packaging or cap, but from upstream sources (filtration or source water)', 'exposure_pathways', 'personal_research', 'Own research with Columbia', 'strong'),
(1, 'Tea bags and hot container cups can release trillions of nanoplastic particles during single use', 'exposure_pathways', 'government_data', 'National Institute of Standards and Technology', 'strong'),
(1, 'Microplastics identified in human lung, liver, kidney, urine, feces, heart, placenta, blood, and breast milk', 'human_presence', 'meta_analysis', 'Multiple peer-reviewed studies', 'strong'),
(1, 'Hawaii placenta samples: 60% contained microplastics in 2006, 90% in 2013, 100% in 2021', 'human_presence', 'peer_reviewed_study', 'Hawaii placenta study spanning 15 years', 'strong'),
(1, 'Nanoplastics identified in placenta and fetal tissues (lung, heart, kidney, liver, brain) within 24 hours after exposure in rat models', 'animal_studies', 'personal_research', 'Own laboratory research', 'strong'),
(1, 'Particles persist in offspring for minimum of six months in rodent studies', 'bioaccumulation', 'personal_research', 'Own laboratory research', 'strong'),
(1, 'Microplastics in fecal matter associated with increased severity of inflammatory bowel disease', 'health_outcomes', 'peer_reviewed_study', NULL, 'moderate'),
(1, 'New England Journal of Medicine March 2024: Micro/nanoplastics in carotid plaque correlated with increased inflammation and cardiovascular risk', 'health_outcomes', 'peer_reviewed_study', 'New England Journal of Medicine, March 2024', 'strong');

-- Scientific claims from Judith Enck (Speaker ID 3)
INSERT INTO scientific_claims (speaker_id, claim_text, claim_category, evidence_type, citations, strength) VALUES
(3, 'Less than 10% of plastics are actually recycled nationally (5-6% according to DOE/EPA)', 'recycling_rates', 'government_data', 'Department of Energy, EPA', 'strong'),
(3, 'In 1950, 2 million tons of plastic produced per year; now 450 million tons per year', 'production_scale', 'government_data', NULL, 'strong'),
(3, 'Microplastics in carotid plaque correlated with 4-fold increased risk of cardiac incident (heart attack, stroke, premature death)', 'health_outcomes', 'peer_reviewed_study', 'New England Journal of Medicine study', 'strong'),
(3, 'By 2030, for every 3 pounds of fish in ocean there will be 1 pound of plastic; by 2050 ratio will be 1:1 without policy change', 'environmental_impact', 'peer_reviewed_study', 'Scientific report read at EPA', 'moderate'),
(3, 'NJ exports second-most plastic to other countries after California', 'waste_export', 'industry_data', NULL, 'moderate'),
(3, 'Chemical recycling handles only 1.3% of total plastic generated in US', 'recycling_rates', 'industry_data', 'Beyond Plastics/IPEN report October 2023', 'strong'),
(3, 'Bottle bill states: aluminum can recycling 77% vs 36% in non-bottle-bill states', 'policy_effectiveness', 'industry_data', 'Container Recycling Institute', 'strong'),
(3, 'Bottle bill states: glass bottle recycling 66% vs 22%', 'policy_effectiveness', 'industry_data', 'Container Recycling Institute', 'strong'),
(3, 'Bottle bill states: PET plastic bottle recycling 57% vs 17%', 'policy_effectiveness', 'industry_data', 'Container Recycling Institute', 'strong'),
(3, 'Plastics have 16,000 different chemicals, making recycling fundamentally difficult', 'material_composition', 'peer_reviewed_study', NULL, 'strong');

-- Scientific claims from Dr. Shanna Swan (Speaker ID 4)
INSERT INTO scientific_claims (speaker_id, claim_text, claim_category, evidence_type, citations, strength) VALUES
(4, 'More than 15,000 chemicals used to manufacture plastics; 25% classified as chemicals of concern; 40% have unknown health risks', 'material_composition', 'meta_analysis', 'Published research compilation', 'strong'),
(4, 'National Toxicology Program 2000: Phthalates fed to pregnant rats caused measurable changes in reproductive systems of male pups (Phthalate Syndrome)', 'animal_studies', 'government_data', 'National Toxicology Program, 2000', 'strong'),
(4, 'Personal research demonstrated Phthalate Syndrome in human male infants (published 2005, replicated in second study)', 'human_health_outcomes', 'personal_research', 'Published 2005, NIH-funded $5M studies (two)', 'strong'),
(4, 'Research influenced Consumer Protection Act of 2008 after Congressional testimony', 'policy_influence', 'personal_research', 'Own testimony record', 'strong'),
(4, 'Worldwide sperm counts have declined 50% since 1970 (about 1% per year)', 'reproductive_health', 'meta_analysis', 'Published 2017 meta-analysis', 'strong'),
(4, '2023 update: Rate of sperm count decline has accelerated, not leveled off', 'reproductive_health', 'peer_reviewed_study', 'Published 2023 update', 'strong'),
(4, 'Total fertility rate has declined worldwide at same rate as sperm count: 1% per year (World Bank data)', 'reproductive_health', 'government_data', 'World Bank fertility data', 'strong'),
(4, 'Number of endangered species more than doubled between 2007 and 2022', 'environmental_impact', 'government_data', NULL, 'moderate'),
(4, 'South Korea fertility rate now 0.8 children per couple (replacement requires 2.1)', 'reproductive_health', 'government_data', NULL, 'strong'),
(4, 'California study: 28-day reduction in EDC-containing personal care products reduced genetic markers predicting breast cancer progression', 'health_intervention', 'peer_reviewed_study', 'Recent California study', 'moderate'),
(4, 'California Prop 65 has listed over 900 chemicals as known or potential endocrine disruptors', 'regulation', 'government_data', 'California Prop 65', 'strong');

-- Claims from Gary Sondermeyer (Speaker ID 2) - Industry perspective
INSERT INTO scientific_claims (speaker_id, claim_text, claim_category, evidence_type, citations, strength) VALUES
(2, 'NJ recovered 113,000 tons plastic containers + 14,000 tons plastic scrap = 127,000 tons total in most recent year', 'recycling_rates', 'government_data', 'NJ DEP database', 'strong'),
(2, '75% overall container recycling rate in NJ; 57% plastic container recycling rate', 'recycling_rates', 'government_data', 'NJ DEP', 'strong'),
(2, 'Average 133,000 tons of plastics recovered per year over past 5 years in NJ', 'recycling_rates', 'government_data', 'NJ DEP 5-year data', 'strong'),
(2, '1.67 metric tons CO2 equivalents avoided for every ton of MSW recycled (EPA)', 'environmental_benefit', 'government_data', 'US EPA', 'strong'),
(2, 'For every pound of recycled PET used in lieu of virgin material, GHG emissions reduced by 71%', 'environmental_benefit', 'government_data', NULL, 'moderate'),
(2, 'NJ has 23 MRFs (material recovery facilities) processing recyclables', 'infrastructure', 'industry_data', 'ANJR', 'strong'),
(2, 'Average disposal cost $90/ton vs plastics revenue exceeds $300/ton - economic incentive is real', 'economics', 'industry_data', 'Bayshore operations data', 'strong'),
(2, 'Approximately 10% residue (non-recyclable material) in recycling stream', 'recycling_rates', 'industry_data', 'Industry average', 'moderate');
