When %r/^I log in as "([^"]*)" with password "([^"]*)"$/ do |login, password|
  When %(I fill in "Login" with "#{login}")
  And %(I fill in "Password" with "#{password}")
  And %(I press "Log in")
end
