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

  Scenario: Attempt to edit a contribution to over 140 characters
    When I choose the contribution "who lived in a castle"
    And I change "who lived in a castle" to "This is quite a long sentence which is one hundred and forty-one characters long, or one letter more than the limit of one hundred and forty."
    And I press "Approve"
    And I should see "mud hut"
    And I should not see "castle"
    And I should see "This is quite a long sentence"
    And I should see "Text is too long (maximum is 140 characters)"
