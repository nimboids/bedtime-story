require "faster_csv"

Then %r/^the response should be a CSV file containing:$/ do |table|
  table.diff! FasterCSV.parse(body)
end
