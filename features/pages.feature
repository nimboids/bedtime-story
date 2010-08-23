Feature: Home page and static information pages

  Scenario: Viewing static pages
    When I go to the home page
    Then the page title should be "Byte Night Bedtime Story"
    And I follow "Byte Night stories"
    Then the page title should be "Byte Night Bedtime Story – Byte Night Stories"
    And I follow "Hints and tips"
    Then the page title should be "Byte Night Bedtime Story – Hints and Tips"
    And I follow "Ideas to get you started"
    Then the page title should be "Byte Night Bedtime Story – Ideas to Get You Started"
    And I follow "Top 10 bedtime story words"
    Then the page title should be "Byte Night Bedtime Story – Top 10 Bedtime Story Words"
    And I follow "Famous contributors"
    Then the page title should be "Byte Night Bedtime Story – Famous Contributors"
    When I follow "Bedtime Story"
    Then I should be on the home page
