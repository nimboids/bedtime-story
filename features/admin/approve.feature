Feature: Admin approval of story contributions

  Scenario: Moderated contribution
    Given the following user exists:
      | login | password |
      | fred  | secret   |
    And the following story contributions exist:
      | text                        | approver_id |
      | there was a king            | 1           |
      | who lived in a mud hut      |             |
      | who lived in a castle       |             |
      | who lived in a council flat |             |
    When I go to the admin page
    And I log in as "fred" with password "secret"
    And I choose "who lived in a castle"
    And I press "Approve"
    And I go to the home page
    Then the story should be:
      | Once upon a time...   |
      | there was a king      |
      | who lived in a castle |
    When I go to the admin page
    Then I should not see "who lived in"
