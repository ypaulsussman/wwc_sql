require 'csv'

table = CSV.parse(File.read('og_protocols.csv'), headers: true)

i = 1
table.each do |row|
  row['id'] = i
  i += 1
  File.open('./protocols.csv', 'a') { |file| file.write(row) }
end
