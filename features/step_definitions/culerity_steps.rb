Then %r/^the cursor should be in the contribution field$/ do
  locate("#story_contribution_text").node.should be_focused
end
