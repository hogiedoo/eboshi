Feature: user accounts
  Background: 
    Given I am signed in as "Micah"
    
  Scenario: User logs out
    When I follow "Logout"
    Then I should see "Logout successful"

