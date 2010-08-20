Then %r/^the story should be:$/ do |table|
  table.raw.flatten.each do |para|
    Then %(I should see "#{para}" within "#story")
  end
end
