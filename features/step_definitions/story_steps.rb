Then %r/^the story should be:$/ do |table|
  table.raw.flatten.each do |para|
    Then %(I should see "#{para}" within "#story")
  end
end

When %r/^a moderator has approved my contribution$/ do
  story_contribution = StoryContribution.last
  story_contribution.approver_id = 1
  story_contribution.save!
end
