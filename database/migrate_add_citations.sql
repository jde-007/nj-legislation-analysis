-- Migration: Add detailed citation fields to evidence table

-- Add new columns for full citations
ALTER TABLE evidence ADD COLUMN authors TEXT;           -- Author list
ALTER TABLE evidence ADD COLUMN title TEXT;             -- Publication title
ALTER TABLE evidence ADD COLUMN journal TEXT;           -- Journal/publication name
ALTER TABLE evidence ADD COLUMN publication_date TEXT;  -- YYYY-MM-DD or YYYY
ALTER TABLE evidence ADD COLUMN volume TEXT;            -- Volume/issue
ALTER TABLE evidence ADD COLUMN pages TEXT;             -- Page numbers
ALTER TABLE evidence ADD COLUMN doi TEXT;               -- Digital Object Identifier
ALTER TABLE evidence ADD COLUMN url TEXT;               -- Direct link to source
ALTER TABLE evidence ADD COLUMN accessed_date TEXT;     -- When source was accessed

SELECT 'Citation columns added to evidence table';
