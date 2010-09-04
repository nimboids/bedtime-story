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
  field = find :xpath, "//input[@value='#{original_text}']"
  field.set edited_text
end

When %r/^a moderator has approved my contribution$/ do
  story_contribution = StoryContribution.last
  story_contribution.approver_id = 1
  story_contribution.save!
end
