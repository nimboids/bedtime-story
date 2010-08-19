Feature: Static pages

  Scenario: Viewing static pages
    When I go to the home page
    Then the page title should be "Byte Night Bedtime Story"
    And I follow "Byte night stories"
    Then the page title should be "Byte Night Bedtime Story – Stories"
