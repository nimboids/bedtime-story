Feature: Admin edit of approved story contributions

  Background:
    Given the following user exists:
      | login | password |
      | fred  | secret   |
    And the following story contributions exist:
      | text                        | approver_id |
      | there was a king            | 1           |
      | who lived in a mud hut      |             |
      | who lived in a castle       | 1           |
    And we stub Twitter API calls
    When I go to the admin page
    And I log in as "fred" with password "secret"
    And I follow "Edit approved contributions"

  Scenario: Only approved contributions are available for editing
    Then I should see "there was a king"
    And I should see "who lived in a castle"
    But I should not see "who lived in a hut"

  Scenario: Edit a contribution
    And I follow "Edit"
    And I change "there was a king" to "There was a queen"
    And I press "Update"
    Then I should see "Contribution updated"
    And I should see "There was a queen"
    But I should not see "there was a king"

  Scenario: Attempt to edit a contribution to over 140 characters
    And I follow "Edit"
    And I change "there was a king" to "This is quite a long sentence which is one hundred and forty-one characters long, or one letter more than the limit of one hundred and forty."
    And I press "Update"
    Then I should see "Text is too long (maximum is 140 characters)"
    And I should see "This is quite a long sentence which is one hundred and forty-one characters long, or one letter more than the limit of one hundred and forty."
