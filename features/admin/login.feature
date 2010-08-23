Feature: Admin login

  Scenario: Successfully log in and out
    Given the following user exists:
      | login | password |
      | fred  | secret   |
    When I go to the admin page
    Then I should be on the login page
    When I fill in "Login" with "fred"
    And I fill in "Password" with "secret"
    And I press "Log in"
    Then I should be on the admin page
    When I follow "Log out"
    Then I should be on the home page
