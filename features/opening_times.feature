Feature: Only accept contributions during opening hours

  Scenario: Closed until 8 a.m BST.
    Given it is 06:59 GMT
    When I go to the home page
    Then I should see "The children are sleeping" within "textarea"
    And the textarea should be disabled
    And the submit button should be disabled

  Scenario: Open from 8 a.m BST.
    Given it is 07:00 GMT
    When I go to the home page
    Then I should not see "The children are sleeping"
    And the textarea should be enabled
    And the submit button should be enabled

  Scenario: Open until 11 p.m BST.
    Given it is 21:59 GMT
    When I go to the home page
    Then I should not see "The children are sleeping"
    And the textarea should be enabled
    And the submit button should be enabled

  Scenario: Closed from 11 p.m BST.
    Given it is 22:00 GMT
    When I go to the home page
    Then I should see "The children are sleeping" within "textarea"
    And the textarea should be disabled
    And the submit button should be disabled

  Scenario: Closed after closing date
    Given it is 0 day, 0 hours, 0 minutes and 0 seconds after the end time
    When I go to the home page
    Then I should see "The book is now closed"
    And I should not see "Now, you continue the story"
