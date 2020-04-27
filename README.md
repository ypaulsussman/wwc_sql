# What Works Clearinghouse's data, in SQL format

The [WWC](https://ies.ed.gov/ncee/wwc/WhoWeAre) is "_a central and trusted source of scientific evidence on education programs, products, practices, and policies._" Their research is second to none, and in a field I consider crucial: but the main site's "quarter-screen mouseover-modal with internal gutters, sidebars, and unpredictable disappearances" isn't the cleanest search-UI, and the available search parameters are somewhat smaller than the entirety of data available.

Because of this, I thought it would be fun to explore the data -- and different ways of interacting with it -- on my own. Downloading the [individual files](https://ies.ed.gov/ncee/wwc/StudyFindings), however, returns a denormalized, entangled mess of CSV files. (_You see this, Excel?! This is why no one likes you!_) 😽

The dataset feels too small (_not to mention too unstructured-text independent!_) to merit porting into something like Elasticsearch. (_In addition, some munging would still be required, e.g. from the 50+_ `bool` _location fields into a more Elasticsearch-idiomatic array of_ `terms`.) 

As such, I decided to work with it in SQL. I submitted a request to WWC, got confirmation of receipt, and... never heard back 🇺🇸😄 ...so I elected to just munge and renormalize the data myself.

That first step was enough of a pain that I've decided to put this project on hold until I can set aside the time to ~~extract `protocols`, `interventions`, et al into the tables they rightfully deserve, add some PK's/FK's, remove duplicated columns,~~ and _maybe_ even spin up a Rails API on top to give me those sweet, sweet ActiveRecord-association abstractions.*

In any case, feel encouraged to grab and make use of the (_denormalized, but still eminently usable!_) `seed_db.sql` file (_or its constituents,_ `seed_schema.sql` _and_ `seed_data.sql`)! 🤘📚 

* **UPDATE:** While the SQL approach is much (_much, much_) faster, computationally, I ended up restarting the process from a Rails-first paradigm. (_Which was much faster, my-poor-brainally._) If interested, you can find that ongoing project at [this repo!](https://github.com/ypaulsussman/wwc_api)

## Replicate the Munging Process

### Initial loading
- Separate `ReviewDictionary.csv` into `Studies_Fields.csv`, `Findings_Fields.csv`, and `InterventionReports_Fields.csv`
- Use `01_prune_fields.rb` to slice out the fields usable for SQL table-generation in  `Studies_Fields_Pruned.csv`, `Findings_Fields_Pruned.csv`, and `InterventionReports_Fields_Pruned.csv`
- Use those three `.csv`'s to manually generate `02_create_tables.sql` 
- Use `03_convert_to_bool.rb` to generate `Studies_booled.csv`, `Findings_booled.csv`, and `InterventionReports_booled.csv`
- `$ psql`
- `=# CREATE DATABASE wwc;`
- `=# \c wwc`
- `=# \! pwd`
- `=# \i your/path/to/02_create_tables.sql`
- While populating from CSV, it became clear several fields' datatypes were inaccurate:
  - `wwc=# alter table intervention_reports alter column protocol_version type numeric(5,2);`
  - `wwc=# alter table intervention_reports alter column ethnicity_hispanic type numeric(5,2);`
  - `wwc=# alter table intervention_reports alter column ethnicity_not_hispanic type numeric(5,2);`
  - `wwc=# alter table intervention_reports alter column outcome_domain type text;`
  - (_Yeah, I know you can combine them, but I like to run each separately out of old atomicity-superstitions..._)
  - Note you'll need to repeat the above for the `studies` table, as well.
- And populate! `wwc=# copy intervention_reports from 'your/path/to/InterventionReports_booled.csv' DELIMITER ',' CSV HEADER;`
  - Tweak and repeat, obviously, for `findings` and `studies` tables
  - Several dozen studies are misformatted for `.csv` (_usually through unescaped HTML or double-quotations._) At ~15k records, the `Studies_booled.csv` file is loadable into a UI; I found it fastest to just use regexp in VSCode to fix these, rather than adding a new script. 
  - Finally, study `1900582` has an inaccurate number of commas; fix it per `studies_munging/study_missing_commas.csv`

### Add `interventions`, `procotols`, and `outcome_domains` tables
- Grab all protocols (_query available in_ `01_all_protocols.txt`; _confirmed prior that_ `studies` _table does contain all values_)
  - Convert to CSV w/ regexp; save as `og_protocols.csv`
  - Use `02_generate_ids.rb` to assign them arbitrary PK's
- Grab all interventions (_queries available in_ `03_all_interventions.txt`; _confirmed prior that no table includes all values_)
  - `$ touch 04_unique_interventions.txt && sort -u 03_all_interventions.txt | tee 04_unique_interventions.txt` to see (_and save!_) unique values
  - Convert to CSV w/ regexp; save as `interventions.csv`
- Grab all outcome domains (_query available in_ `05_all_outcome_domains.txt`; _confirmed prior that the 52 unique values in_ `intervention_reports` _are a subset of the 88 in_ `findings`)
  - Convert to CSV w/ regexp; save as `og_domains.csv`
  - Modify `02_generate_ids.rb` to assign them arbitrary PK's
- Manually generate `add_new_tables.sql`
- `$ psql wwc`
- `=# \i your/path/to/add_new_tables.sql`

### Add primary and foreign keys
- `$ psql wwc`
- `=# \i your/path/to/add_primary_foreign_keys.sql`

### Final refinements
- Run `$ ruby path/to/04_final_refinements.rb` for the following:
  - Many of the `intervention_reports` fields don't appear to contain anything beyond aggregated data from their constituent `studies`; drop them for now (_you can recalculate on the fly or in a matview if later needed._)
  - _@Y TODO: convert studies' 50 states cols to many-many join_
  - The more I think about it, the more it irks me to call it the `studies` table: the `citation` field isn't unique; rather, it's the (formerly named) `ReviewID` field which joins this table to `findings`. As such? Rename it. In fact, go back to `add_new_tables.sql` and update the `findings` fk, preemptively, as well. 
- If _you_ want, the `OutcomeMeasureID` and `Outcome_Measure` fields on `findings` are ripe for extraction to a new table, but given that [1] there's a long tail of values there (_sth like ~2500 unique values for ~6k records, of which only ~90 have more than 10 associated records_), [2] the values are only present on the one table, and [3] I was _reaaaaaaaally_ done with ETL and munging at this point, I left it untouched. ...for now.
