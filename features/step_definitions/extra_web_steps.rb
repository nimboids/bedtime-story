Then %r/^the response status should be (\d+)$/ do |status|
  response.response_code.should == status
end

Then %r/^the page title should be "([^"]*)"$/ do |title|
  Then %(I should see "#{title}" within "title")
end

When %r/^I fill in "([^"]*)" with a (\d+) character string$/ do |field, characters|
  string = characters.to_i.times.map{ 'a' }.join
  When %(I fill in "#{field}" with "#{string}")
end

Then %r/^the textarea should be disabled$/ do
  find("#story_contribution_text")["disabled"].should_not be_nil
end

Then %r/^the textarea should be enabled$/ do
  find("#story_contribution_text")["disabled"].should be_nil
end

Then %r/^the submit button should be disabled$/ do
  find("#story_contribution_submit")["disabled"].should_not be_nil
end

Then %r/^the submit button should be enabled$/ do
  find("#story_contribution_submit")["disabled"].should be_nil
end
