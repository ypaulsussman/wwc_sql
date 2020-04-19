CREATE TABLE IF NOT EXISTS interventions(
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);

copy interventions from '/Users/ypaulsussman/Desktop/wwc_sql/add_protocol_intervention_tables/interventions.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE IF NOT EXISTS protocols(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  version NUMERIC(5,2) NOT NULL
);

copy protocols from '/Users/ypaulsussman/Desktop/wwc_sql/add_protocol_intervention_tables/protocols.csv' DELIMITER ',' CSV HEADER;
