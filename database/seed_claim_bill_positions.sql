-- Seed claim_bill_positions from existing data
-- Links claims to the bills they were presented regarding

-- Dr. Swan's claims regarding A4367 (Toxic Packaging Reduction Act)
-- Her testimony directly supported this bill
INSERT OR IGNORE INTO claim_bill_positions (claim_id, bill_id, position, position_notes)
SELECT c.id, 1, 'for', 'Claim supports banning phthalates/bisphenols in packaging'
FROM claims c
JOIN testimony t ON c.testimony_id = t.id
JOIN witnesses w ON t.witness_id = w.id
WHERE w.name = 'Dr. Shanna Swan';

-- Dr. Stapleton's claims - general scientific evidence, neutral to specific bills
INSERT OR IGNORE INTO claim_bill_positions (claim_id, bill_id, position, position_notes)
SELECT c.id, 4, 'neutral', 'Scientific background on nanoplastics relevant to microplastics testing'
FROM claims c
JOIN testimony t ON c.testimony_id = t.id
JOIN witnesses w ON t.witness_id = w.id
WHERE w.name = 'Dr. Phoebe Stapleton';

-- Climate scientists' claims regarding flood/hazard mitigation bills
-- Dr. Broccoli, Dr. Lin, Dr. Herrington - support for climate resilience legislation
INSERT OR IGNORE INTO claim_bill_positions (claim_id, bill_id, position, position_notes)
SELECT c.id, 5, 'for', 'Climate data supports need for flood mitigation'
FROM claims c
JOIN testimony t ON c.testimony_id = t.id
JOIN witnesses w ON t.witness_id = w.id
WHERE w.name IN ('Dr. Anthony Broccoli', 'Dr. Ning Lin', 'Dr. Thomas Herrington');

-- Verify
SELECT 'Claim-bill positions seeded: ' || COUNT(*) FROM claim_bill_positions;
