# frozen_string_literal: true

require 'csv'

CSV.foreach('./Studies_Fields.csv', headers: true) do |row|
  row.delete('Level')
  row.delete('Merged File Variable Names')
  row.delete('Description')

  row['Type'] = 'numeric(5, 2)' if row['Type'] == 'percent'
  File.write('./Studies_Fields_Pruned.csv', row, mode: 'a+')
end
