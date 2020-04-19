# What Works Clearinghouse's data, in SQL format

The [WWC](https://ies.ed.gov/ncee/wwc/WhoWeAre) is "_a central and trusted source of scientific evidence on education programs, products, practices, and policies._" Their research is second to none, and in a field I consider crucial: but the main site's "quarter-screen mouseover-modal with internal gutters, sidebars, and unpredictable disappearances" isn't the cleanest search-UI, and the available search parameters are somewhat smaller than the entirety of data available.

Because of this, I thought it would be fun to explore the data -- and different ways of interacting with it -- on my own. Downloading the [individual files](https://ies.ed.gov/ncee/wwc/StudyFindings), however, returns a denormalized, entangled mess of CSV files. (_You see this, Excel?! This is why no one likes you!_) 😽

The dataset feels too small (_not to mention too unstructured-text independent!_) to merit porting into something like Elasticsearch. (_In addition, some munging would still be required, e.g. from the 50+_ `bool` _location fields into a more Elasticsearch-idiomatic array of_ `terms`.) 

As such, I decided to work with it in SQL. I submitted a request to WWC, got confirmation of receipt, and... never heard back 🇺🇸😄 ...so I elected just to munge and renormalize the data myself.

That first step was enough of a pain that I've decided to put this project on hold until I can set aside the time to extract `protocols`, `interventions`, et al into the tables they rightfully deserve, add some PK's/FK's, and _maybe_ even spin up a Rails API on top to give me those sweet, sweet ActiveRecord-association abstractions.

In any case, feel welcome to grab the (_denormalized, but still eminently usable!_) `initial_data.sql` file and make use of it! 🤘📚

## Replicate the Munging Process

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
- And populate! `wwc=# copy intervention_reports from '/Users/ypaulsussman/Desktop/wwc_sql/ir_munging/InterventionReports_booled.csv' DELIMITER ',' CSV HEADER;`
  - Tweak and repeat, obviously, for `findings` and `studies` tables
  - Several dozen studies are misformatted for `.csv` (_usually through unescaped HTML or double-quotations._) At ~15k records, the `Studies_booled.csv` file is loadable into a UI; I found it fastest to just use regexp in VSCode to fix these, rather than adding a new script. 
  - Finally, study `1900582` has an inaccurate number of commas; fix it per `studies_munging/study_missing_commas.csv`
