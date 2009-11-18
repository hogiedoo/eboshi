Feature: Administrator User Status
  Scenario: Admin logs in and views all users
    Given the following users exist:
      | name    |
      | Micah   |
      | Michael |
      | Tony    |
    And I am signed in as an Admin
    Then I should see "All Users"

    When I go to /users
    Then I should see "Micah"
    And I should see "Michael"
    And I should see "Tony"
    
  Scenario: Micah logs in and tries to view all users
    Given the following users exist:
      | name    |
      | Admin   |
      | Michael |
      | Tony    |
    And I am signed in as "Micah"
    Then I should not see "All Users"
    And I should not be able to go to /users
