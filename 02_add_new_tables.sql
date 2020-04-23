CREATE TABLE IF NOT EXISTS public.interventions(
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);

copy public.interventions from '/Users/ypaulsussman/Desktop/wwc_sql/add_new_tables/interventions.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE IF NOT EXISTS public.protocols(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  version NUMERIC(5,2) NOT NULL
);

copy public.outcome_domains from '/Users/ypaulsussman/Desktop/wwc_sql/add_new_tables/protocols.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE IF NOT EXISTS public.outcome_domains(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

copy public.outcome_domains from '/Users/ypaulsussman/Desktop/wwc_sql/add_new_tables/outcome_domains.csv' DELIMITER ',' CSV HEADER;
