-- INITIAL KEYS
-- Add pks/fks to studies, findings, intervention_reports

ALTER TABLE studies ADD PRIMARY KEY (reviewid);

ALTER TABLE studies RENAME COLUMN reviewid TO id;

ALTER TABLE findings ADD PRIMARY KEY (findingid);

ALTER TABLE findings RENAME COLUMN findingid TO id;

ALTER TABLE intervention_reports ADD COLUMN id SERIAL PRIMARY KEY;

-- Add studies fk to findings
DELETE FROM findings WHERE reviewid NOT IN (SELECT id FROM studies);

-- This constraint won't work without further munging; 1009 `findings` records reference 136 `reviewid` values that aren't present in the `studies` data... hence the somewhat-disappointing deletion beforehand.
ALTER TABLE findings ADD CONSTRAINT constraint_fk_studies FOREIGN KEY (reviewid) REFERENCES studies (id);

ALTER TABLE findings RENAME COLUMN reviewid TO study_id;


-- PROTOCOLS
-- Add protocols fk to studies

ALTER TABLE studies ADD COLUMN protocol_id INTEGER;

UPDATE studies s SET protocol_id = (SELECT id FROM protocols p WHERE p.name = s.protocol AND p.version = s.protocol_version);

ALTER TABLE studies ADD CONSTRAINT constraint_fk_protocols FOREIGN KEY (protocol_id) REFERENCES protocols (id);

ALTER TABLE studies DROP COLUMN IF EXISTS protocol;

ALTER TABLE studies DROP COLUMN IF EXISTS protocol_version;

-- Add protocols fk to intervention_reports

ALTER TABLE intervention_reports ADD COLUMN protocol_id INTEGER;

UPDATE intervention_reports i SET protocol_id = (SELECT id FROM protocols p WHERE p.name = i.protocol AND p.version = i.protocol_version);

ALTER TABLE intervention_reports ADD CONSTRAINT constraint_fk_protocols FOREIGN KEY (protocol_id) REFERENCES protocols (id);

ALTER TABLE intervention_reports DROP COLUMN IF EXISTS protocol;

ALTER TABLE intervention_reports DROP COLUMN IF EXISTS protocol_version;

-- Drop `protocol` field from `findings`: its value is already present in `studies`, and there's weirdly no corresponding `protocol_version` field on the table

ALTER TABLE findings DROP COLUMN IF EXISTS protocol;


-- INTERVENTIONS
-- Add interventions fk to studies

ALTER TABLE studies RENAME COLUMN interventionid TO intervention_id;

ALTER TABLE studies ADD CONSTRAINT constraint_fk_interventions FOREIGN KEY (intervention_id) REFERENCES interventions (id);

ALTER TABLE studies DROP COLUMN IF EXISTS intervention_name;

-- Add interventions fk to findings

ALTER TABLE findings RENAME COLUMN interventionid TO intervention_id;

ALTER TABLE findings ADD CONSTRAINT constraint_fk_interventions FOREIGN KEY (intervention_id) REFERENCES interventions (id);

ALTER TABLE findings DROP COLUMN IF EXISTS intervention_name;

-- Add interventions fk to intervention_reports

ALTER TABLE intervention_reports RENAME COLUMN interventionid TO intervention_id;

ALTER TABLE intervention_reports ADD CONSTRAINT constraint_fk_interventions FOREIGN KEY (intervention_id) REFERENCES interventions (id);

ALTER TABLE intervention_reports DROP COLUMN IF EXISTS intervention_name;
