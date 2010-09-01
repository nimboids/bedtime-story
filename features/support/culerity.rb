# Bundler 1.0 hack: http://github.com/carlhuda/bundler/issues/issue/478
if ENV['RUBYOPT']
  ENV['RUBYOPT'] = ENV['RUBYOPT'].gsub(%r{-r\s*bundler/setup}, '')
end

Then %r/^the submit button should be disabled$/ do
  find("#story_contribution_submit")["disabled"].should_not be_nil
end

Then %r/^the submit button should be enabled$/ do
  find("#story_contribution_submit")["disabled"].should be_nil
end
