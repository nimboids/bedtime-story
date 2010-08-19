When %r/I print the response/ do
  puts response.body
end

Then %r/^the page title should be "([^"]*)"$/ do |title|
  Then %(I should see "#{title}" within "title")
end
