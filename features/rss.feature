Feature: RSS feed

  Scenario: Retreiving RSS feed
    Given the following story contributions exist:
      | text                  | approver_id | name |
      | there was a king      | 1           | Fred |
      | who lived in a swamp  |             | Bob  |
      | who lived in a castle | 1           |      |
    When I go to the RSS page
    Then I should see "there was a king" within "item title"
    And I should see "Fred" within "item creator"
    And I should not see "who lived in a swamp"
    And I should not see "Bob"
    And I should see "who lived in a castle"
