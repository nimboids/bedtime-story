Given %r/^the story is not cached/ do
  ActionController::Base.new.expire_fragment "story"
end

Given %r/^the site is open for contributions$/ do
  Given %(it is 12:00 GMT)
end

Then %r/^the story should be:$/ do |table|
  table.raw.flatten.each do |para|
    Then %(I should see "#{para}" within "#story")
  end
end

When %r/^I choose the contribution "([^"]*)"$/ do |text|
  third_contribution = StoryContribution.find_by_text text
  When %(I choose "story_contribution_#{third_contribution.id}")
end

When %r/^I change "([^"]*)" to "([^"]*)"$/ do |original_text, edited_text|
  field = find :xpath, "//textarea[text()='#{original_text}']"
  field.set edited_text
end

When %r/^a moderator has approved my contribution$/ do
  story_contribution = StoryContribution.last
  story_contribution.approver_id = 1
  story_contribution.save!
  Given %(the story is not cached)
end

Given %r/^the contribution "([^"]*)" is approved by "([^"]*)"$/ do |text, approver|
  contrib = StoryContribution.find_by_text text
  contrib.approver = User.find_by_login approver
  contrib.save
end

Then %r/^my contribution should be credited to "([^"]*)", "([^"]*)"$/ do |name, email|
  story_contribution = StoryContribution.last
  story_contribution.name.should == name
  story_contribution.email.should == email
end
