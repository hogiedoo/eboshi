Feature: User accounts

  Scenario: User logs out
    Given I am signed in as "Micah"
    When I follow "Logout"
    Then I should see "Logout successful"
    
  Scenario: Add user
    Given I am signed in as "Micah"
    Given I follow "Add Client"
    And I fill in "Company Name" with "Domaine Selections"
    And I press "Create"
    Then I should see "Domaine Selections" under "Clients"
