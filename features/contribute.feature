Feature: Contributing to the story

  @javascript
  Scenario: Initial focus on page load
    When I go to the home page
    Then the cursor should be in the contribution field

  Scenario: Moderated contribution
    When I go to the home page
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

  @javascript
  Scenario: Live validation of text length
    When I go to the home page
    Then I should see "140 characters remaining" within ".valid"
    When I fill in "Now, you continue the story" with "I"
    Then I should see "139 characters remaining" within ".valid"

  Scenario: A 0 character story contribution is rejected
    When I go to the home page
    And I fill in "Now, you continue the story" with a 0 character string
    And I press "Submit"
    Then I should see "Text can't be blank"

  Scenario: A 1 character story contribution is accepted
    When I go to the home page
    And I fill in "Now, you continue the story" with a 1 character string
    And I press "Submit"
    Then I should see "Your contribution is awaiting moderation"

  Scenario: A 140 character story contribution is accepted
    When I go to the home page
    And I fill in "Now, you continue the story" with a 140 character string
    And I press "Submit"
    Then I should see "Your contribution is awaiting moderation"

  Scenario: A 141 character story contribution is rejected
    When I go to the home page
    And I fill in "Now, you continue the story" with a 141 character string
    And I press "Submit"
    Then I should see "Text is too long (maximum is 140 characters)"

