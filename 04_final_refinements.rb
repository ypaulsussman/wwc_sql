# frozen_string_literal: true

require 'pg'

# rubocop:disable Layout/LineLength
DUP_COLS = ['Class_type_General', 'Class_type_Inclusion', 'Delivery_Method_Individual', 'Delivery_Method_School', 'Delivery_Method_Small_Group', 'Delivery_Method_Whole_Class', 'Demographics_of_Study_Sample_English_language_learners', 'Demographics_of_Study_Sample_Free_or_reduced_price_lunch', 'Demographics_of_Study_Sample_International', 'Demographics_of_Study_Sample_Students_with_disabilities', 'Ethnicity_Hispanic', 'Ethnicity_Not_Hispanic', 'Gender_Female', 'Gender_Male', 'Grade_1', 'Grade_10', 'Grade_11', 'Grade_12', 'Grade_2', 'Grade_3', 'Grade_4', 'Grade_5', 'Grade_6', 'Grade_7', 'Grade_8', 'Grade_9', 'Grade_K', 'Grade_PK', 'Grade_PS', 'Program_Type_Curriculum', 'Program_Type_Policy', 'Program_Type_Practice', 'Program_Type_School_level', 'Program_Type_Supplement', 'Program_Type_Teacher_level', 'Race_Asian', 'Race_Black', 'Race_Native_American', 'Race_Other', 'Race_Pacific_Islander', 'Race_White', 'Region_State_Alabama', 'Region_State_Alaska', 'Region_State_Arizona', 'Region_State_Arkansas', 'Region_State_California', 'Region_State_Colorado', 'Region_State_Connecticut', 'Region_State_Delaware', 'Region_State_District_of_Columbia', 'Region_State_Florida', 'Region_State_Georgia', 'Region_State_Hawaii', 'Region_State_Idaho', 'Region_State_Illinois', 'Region_State_Indiana', 'Region_State_Iowa', 'Region_State_Kansas', 'Region_State_Kentucky', 'Region_State_Louisiana', 'Region_State_Maine', 'Region_State_Maryland', 'Region_State_Massachusetts', 'Region_State_Michigan', 'Region_State_Midwest', 'Region_State_Minnesota', 'Region_State_Mississippi', 'Region_State_Missouri', 'Region_State_Montana', 'Region_State_Nebraska', 'Region_State_Nevada', 'Region_State_New_Hampshire', 'Region_State_New_Jersey', 'Region_State_New_Mexico', 'Region_State_New_York', 'Region_State_North_Carolina', 'Region_State_North_Dakota', 'Region_State_Northeast', 'Region_State_Ohio', 'Region_State_Oklahoma', 'Region_State_Oregon', 'Region_State_Pennsylvania', 'Region_State_Rhode_Island', 'Region_State_South', 'Region_State_South_Carolina', 'Region_State_South_Dakota', 'Region_State_Tennessee', 'Region_State_Texas', 'Region_State_Utah', 'Region_State_Vermont', 'Region_State_Virginia', 'Region_State_Washington', 'Region_State_West', 'Region_State_West_Virginia', 'Region_State_Wisconsin', 'Region_State_Wyoming', 'School_type_Charter', 'School_type_Parochial', 'School_type_Private', 'School_type_Public', 'Urbanicity_Rural', 'Urbanicity_Suburban', 'Urbanicity_Urban'].freeze
# rubocop:enable Layout/LineLength

conn = PG.connect(dbname: 'wwc')

# Yep, my pl/pgSQL-fu is this actually this bad
DUP_COLS.each do |colname|
  conn.exec("ALTER TABLE intervention_reports DROP COLUMN #{colname};") { |result| puts result }
end

# See README.md
conn.exec('ALTER TABLE studies RENAME TO study_reviews;')
