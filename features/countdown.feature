Feature: Countdown timer

  Scenario: Should be displayed
    Given I freeze time to 27/08/10 14:00:00
    When I go to the home page
    Then I should see "34" within "#countdown_days"
    And I should see "days" within ".countdown"
    Then I should see "9" within "#countdown_hours"
    And I should see "hours" within ".countdown"
    Then I should see "59" within "#countdown_minutes"
    And I should see "minutes" within ".countdown"
    Then I should see "0" within "#countdown_seconds"
    And I should see "seconds" within ".countdown"

