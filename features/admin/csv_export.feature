Feature: CSV export

  Scenario: Exporting story contributions to CSV
    Given the following users exist:
      | login | password | email            |
      | fred  | secret   | fred@example.com |
      | bob   | foobar   | bob@example.com  |
    And the following story contributions exist:
      | text                        | name         | email                  |
      | there was a king            | AN Other     | a.n.other@example.com  |
      | who lived in a mud hut      |              |                        |
      | who lived in a castle       |              |                        |
      | who lived in a council flat | Mickey Mouse | m.mouse@example.com    |
      | with a tortoise             | Some Bloke   | some.bloke@example.com |
    And the contribution "there was a king" is approved by "fred"
    And the contribution "with a tortoise" is approved by "bob"
    When I go to the admin page
    When I log in as "fred" with password "secret"
    And I follow "Export story as CSV"
    Then the response content type should be "application/csv"
    And the response should be a CSV file containing:
      | Text                        | Name         | E-mail address         | Approved? | Approved by      |
      | there was a king            | AN Other     | a.n.other@example.com  | Y         | fred@example.com |
      | who lived in a mud hut      |              |                        | N         |                  |
      | who lived in a castle       |              |                        | N         |                  |
      | who lived in a council flat | Mickey Mouse | m.mouse@example.com    | N         |                  |
      | with a tortoise             | Some Bloke   | some.bloke@example.com | Y         | bob@example.com  |
