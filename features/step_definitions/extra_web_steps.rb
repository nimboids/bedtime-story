When %r/I print the response/ do
  puts response.body
end

Then %r/^the page title should be "([^"]*)"$/ do |title|
  Then %(I should see "#{title}" within "title")
end

When %r/^I fill in "([^"]*)" with a (\d+) character string$/ do |field, characters|
  string = characters.to_i.times.map{ 'a' }.join
  When %(I fill in "#{field}" with "#{string}")
end
