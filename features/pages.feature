Feature: Home page and static information pages

  Scenario: Viewing static pages
    When I go to the home page
    Then the page title should be "Byte Night Bedtime Story"
    When I follow "Byte Night stories"
    Then the page title should be "Byte Night Bedtime Story – Byte Night Stories"
    When I follow "Hints and tips"
    Then the page title should be "Byte Night Bedtime Story – Hints and Tips"
    When I follow "Top bedtime story phrases"
    Then the page title should be "Byte Night Bedtime Story – Top Bedtime Story Phrases"
    When I follow "Famous contributors"
    Then the page title should be "Byte Night Bedtime Story – Famous Contributors"
    When I follow "FAQ"
    Then the page title should be "Byte Night Bedtime Story – Frequently-Asked Questions"
    When I follow "Terms & Conditions"
    Then the page title should be "Byte Night Bedtime Story – Terms & Conditions"

  Scenario: Getting back home
    Given I am on the stories page
    When I follow "Home"
    Then I should be on the home page
    Given I am on the stories page
    When I follow "Bedtime Story"
    Then I should be on the home page

  Scenario: Missing page
    When I go to a nonexistent page
    Then I should see "The page you were looking for doesn't exist"
