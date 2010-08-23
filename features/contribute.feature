Feature: Contributing to the story

  Scenario: Unmoderated contribution
    Given I go to the home page
    Then the story should be:
      | Once upon a time... |
    When I fill in "Now, you continue the story" with "there was a castle on the hill"
    And I press "Submit"
    Then the story should be:
      | Once upon a time...            |
      | there was a castle on the hill |
