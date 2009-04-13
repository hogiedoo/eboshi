Feature: User accounts
  Background: 
    Given I am signed in as "Micah"
    
  Scenario: User logs out
    When I follow "Logout"
    Then I should see "Logout successful"
    
  Scenario: Add user
    Given I follow "Add Client"
    And I fill in "Company Name" with "Domaine Selections"
    And I press "Create"
    Then I should see "Domaine Selections" under "Clients"
