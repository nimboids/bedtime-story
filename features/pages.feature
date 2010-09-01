Feature: Home page and static information pages

  Scenario: Viewing static pages
    When I go to the home page
    Then the page title should be "Byte Night Bedtime Story"
    When I follow "Byte Night stories"
    Then the page title should be "Byte Night Bedtime Story – Byte Night Stories"
    When I follow "Hints and tips"
    Then the page title should be "Byte Night Bedtime Story – Hints and Tips"
    When I follow "Ideas to get you started"
    Then the page title should be "Byte Night Bedtime Story – Ideas to Get You Started"
    When I follow "Top 10 bedtime story words"
    Then the page title should be "Byte Night Bedtime Story – Top 10 Bedtime Story Words"
    When I follow "Famous contributors"
    Then the page title should be "Byte Night Bedtime Story – Famous Contributors"
    When I follow "Privacy Policy"
    Then the page title should be "Byte Night Bedtime Story – Privacy Policy"
    When I follow "Terms & Conditions"
    Then the page title should be "Byte Night Bedtime Story – Terms & Conditions"

  Scenario: Getting back home
    Given I am on the stories page
    When I follow "Home"
    Then I should be on the home page
    Given I am on the stories page
    When I follow "Bedtime Story"
    Then I should be on the home page

  @wip
  Scenario: Proper content on pages
    When I go to the home page
    Then I should not see "TODO"
    When I follow "Byte Night stories"
    Then I should not see "TODO"
    When I follow "Hints and tips"
    Then I should not see "TODO"
    When I follow "Ideas to get you started"
    Then I should not see "TODO"
    When I follow "Top 10 bedtime story words"
    Then I should not see "TODO"
    When I follow "Famous contributors"
    Then I should not see "TODO"
    When I follow "Privacy Policy"
    Then I should not see "TODO"
    When I follow "Terms & Conditions"
    Then I should not see "TODO"
