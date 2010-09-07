Feature: Countdown timer

  Scenario: Should be displayed
    Given I freeze time to 1 day, 2 hours, 3 minutes and 4 seconds before the end time
    When I go to the home page
    Then I should see "1" within "#countdown_days"
    And I should see "days" within ".countdown"
    And I should see "2" within "#countdown_hours"
    And I should see "hours" within ".countdown"
    And I should see "3" within "#countdown_minutes"
    And I should see "minutes" within ".countdown"
    And I should see "4" within "#countdown_seconds"
    And I should see "seconds" within ".countdown"

  @javascript
  Scenario: Live countdown
    Given I freeze time to 1 day, 0 hours, 0 minutes and 0 seconds before the end time
    When I go to the home page
    Then I should see "1" within "#countdown_days"
    And I should see "0" within "#countdown_hours"
    And I should see "0" within "#countdown_minutes"
    And I should see "0" within "#countdown_seconds"
    When I wait for 1.5 seconds
    Then I should see "0" within "#countdown_days"
    And I should see "23" within "#countdown_hours"
    And I should see "59" within "#countdown_minutes"
    And I should see "59" within "#countdown_seconds"

  @javascript
  Scenario: Live countdown on page other than home
    Given I freeze time to 1 day, 0 hours, 0 minutes and 0 seconds before the end time
    When I go to the stories page
    Then I should see "1" within "#countdown_days"
    When I wait for 1.5 seconds
    Then I should see "0" within "#countdown_days"
