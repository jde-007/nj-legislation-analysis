-- Legislative measures mentioned and recommended in the April 22, 2024 hearing
-- Based on transcript analysis

-- Existing NJ legislation referenced
INSERT INTO legislative_outcomes (hearing_id, bill_number, bill_title, bill_status, summary, key_provisions, connection_to_hearing) VALUES
(1, 'Recycling Enhancement Act (1987)', 'NJ Mandatory Recycling Law', 'Enacted', 
'First mandatory recycling law in the nation, enacted 1987. Provides framework for statewide recycling requirements.',
'Mandated recycling in all 564 municipalities; 21 counties required to include recyclables in county plans; created municipal tonnage grants program ($22M/year); 10% to education',
'Gary Sondermeyer cited this as foundational. Said current NJ system handles 127,000 tons plastics/year'),

(1, 'Clean Communities Act (1986)', 'NJ Litter Control Law', 'Enacted',
'First extended producer responsibility law in NJ, predating mandatory recycling. Addresses all litter, not just bottles.',
'Litter-producing industries pay for cleanup; funds anti-litter efforts statewide',
'Sondermeyer called this "NJs first extended producer responsibility law 38 years ago"'),

(1, 'Recycled Content Legislation', 'Recycled Content Requirements', 'Enacted (milestones began Jan 2024)',
'Requires minimum recycled content in plastic products sold in NJ. Initial targets began January 18, 2024.',
'Sets minimum recycled content percentages for plastic products',
'Sondermeyer: "most important piece of recycling legislation since the mandatory law"'),

(1, 'Recycling Market Development Council Act', 'RMDC Creation', 'Enacted/Report Published April 2022',
'Created council to study and recommend improvements to NJs recycling infrastructure.',
'15 specific recommendations in April 2022 report including: statewide recycling education, uniform recyclables list, truth in labeling, financial assistance programs, EPR',
'Multiple speakers referenced this. Sondermeyer said recommendations still need implementation'),

(1, 'Plastic Bag Ban', 'Single-Use Bag Restriction', 'Enacted/Effective 2022',
'Banned single-use plastic bags at retail establishments.',
'Prohibited single-use plastic bags; required reusable bags',
'Multiple speakers referenced as successful example of behavior change legislation'),

(1, 'Climate Education K-12 Mandate', 'Climate Education Requirements', 'Enacted',
'First state to require climate education K-12 in schools.',
'Mandatory climate curriculum in all grade levels',
'Sondermeyer cited as platform to integrate recycling/composting education');

-- Legislative recommendations made during hearing
INSERT INTO legislative_outcomes (hearing_id, bill_number, bill_title, bill_status, summary, key_provisions, connection_to_hearing) VALUES
(1, 'Extended Producer Responsibility (EPR)', 'Packaging EPR Legislation', 'Recommended/Pending',
'Shift financial and legal responsibility for packaging waste from taxpayers to producers.',
'Would require producers to fund recycling/disposal of their packaging; shift costs from municipalities',
'Both Sondermeyer (ANJR supports) and Enck (Beyond Plastics) strongly recommended; emphasized needs-assessment component'),

(1, 'Bottle Bill/Deposit Container Law', 'NJ Beverage Container Deposit', 'Recommended/Debated',
'Refundable deposit on beverage containers to increase recycling rates and reduce litter.',
'5-10 cent deposit on bottles/cans; reverse vending machines; redemption centers; refillable container provisions',
'Judith Enck strongly recommended; ANJR (Sondermeyer) opposed, saying it would undermine existing infrastructure'),

(1, 'Packaging Reduction Law', '50% Plastic Packaging Reduction', 'Recommended',
'Mandatory reduction in plastic packaging over 10 years with glide path.',
'10% reduction in 2 years; 20% in 4 years; eventual 50% total reduction; environmental standards for packaging',
'Enck: "fuel efficiency standards for packaging" - strongest recommendation'),

(1, 'Uniform Recyclables List', 'Statewide Recycling Standards', 'Recommended/In Development',
'Single statewide list of what is recyclable to reduce confusion.',
'Replace 21 county lists with one uniform list; models from Colorado, Oregon, Connecticut',
'Sondermeyer said ANJR working on this; could be voluntary like Connecticut'),

(1, 'Chemical Recycling Regulation', 'Chemical Recycling Ban/Restriction', 'Recommended',
'Prohibit chemical recycling from counting as recycling; restrict taxpayer subsidies.',
'Ban pyrolysis facilities from being classified as manufacturing; prevent taxpayer subsidies; restrict chemical recycling claims',
'Enck strongly opposed chemical recycling - "1.3% of plastic, been failing since the 80s"'),

(1, 'Polystyrene Ban', 'Expand Single-Use Plastic Bans', 'Recommended',
'Expand existing bans to include polystyrene and other problematic plastics.',
'Ban polystyrene containers statewide; expand restrictions on difficult-to-recycle plastics',
'Mentioned in context of California EPR negotiations'),

(1, 'Plastic Export Restrictions', 'Limit Plastic Waste Exports', 'Recommended/Flagged',
'Address NJ being #2 plastic exporter in US.',
'Restrict export of plastic waste to countries without recycling infrastructure',
'Enck flagged NJ as #2 exporter after California; referenced PBS Frontline "Plastic Wars"');
