Feature: Contributing to the story

  Scenario: Moderated contribution
    Given I go to the home page
    Then the story should be:
      | Once upon a time... |
    When I fill in "Now, you continue the story" with "there was a castle on the hill"
    And I press "Submit"
    Then I should see "Your contribution is awaiting moderation"
    And I should not see "there was a castle on the hill"
    When a moderator has approved my contribution
    And I go to the home page
    Then the story should be:
      | Once upon a time...            |
      | there was a castle on the hill |
