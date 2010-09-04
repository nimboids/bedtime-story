Feature: Admin approval of story contributions

  Background:
    Given the following user exists:
      | login | password |
      | fred  | secret   |
    And the following story contributions exist:
      | text                        | approver_id | name         |
      | there was a king            | 1           |              |
      | who lived in a mud hut      |             |              |
      | who lived in a castle       |             |              |
      | who lived in a council flat |             | Mickey Mouse |
    When I go to the admin page
    When I log in as "fred" with password "secret"

  Scenario: Approve unedited
    Then I should see "by Mickey Mouse"
    When I choose the contribution "who lived in a castle"
    And I press "Approve"
    And I go to the home page
    Then the story should be:
      | Once upon a time...   |
      | there was a king      |
      | who lived in a castle |
    When I go to the admin page
    Then I should not see "who lived in"

  Scenario: Edit and approve
    When I choose the contribution "who lived in a castle"
    And I change "who lived in a castle" to "who lived in an enchanted castle"
    And I press "Approve"
    And I go to the home page
    Then the story should be:
      | Once upon a time...              |
      | there was a king                 |
      | who lived in an enchanted castle |
