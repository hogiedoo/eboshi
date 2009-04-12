Feature: Manage client-user associations
  Background:
    Given I am signed in as "Micah"
    And the following users exist:
      | name |
      | Michael |
      | Kit |
    And the following clients exist:
      | name |
      | cheapbowlingballs.com |
      | bossanova |
      | g2a |
      | fashions weekly |
    And the user "Micah" has the following assignments:
      | client |
      | cheapbowlingballs.com |
      | bossanova |
    And the user "Michael" has the following assignments:
      | client |
      | g2a |
      | bossanova |
    And the user "Kit" has the following assignments:
      | client |
      | fashions weekly |
  
  Scenario: View assigned clients
    Given I am on "/"
    Then I should see "cheapbowlingballs.com" under "Clients"
    And I should see "bossanova" under "Clients"
    And I should not see "g2a" under "Clients"
    And I should not see "fashions weekly" under "Clients"
    
  Scenario: Collaborator list
    Given I am on the invoices page for "bossanova"
    Then I should see "Michael" under "Collaborators"
    And I should not see "Kit" under "Collaborators"
    
  Scenario: User deletes anothers assignment
    Given I am on the invoices page for "bossanova"
    And I click "delete" next to "Michael"
    Then I should not see "Michael" under "Collaborators"
        
  Scenario: User deletes own assignment
    Given I am on the invoices page for "bossanova"
    And I click "delete" next to "Micah"
    Then I should not see "bossanova" under "Clients"
    
  Scenario: User sees a list of current associates on the invite collaborator page
    Given I am on the invoices page for "cheapbowlingballs.com"
    And I follow "Invite collaborator"
    Then I should see "Michael" under "Existing User"
    And I should not see "Kit" under "Existing User"
    
  Scenario: User invites a collaborator onto a project
    Given I am on the invoices page for "cheapbowlingballs.com"
    And I follow "Invite collaborator"
    And I choose "Michael"
    And I press "Invite"
    Then I should see "Michael" under "Collaborators"
