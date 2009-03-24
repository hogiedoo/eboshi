Feature: Manage client-user associations
  Background:
    Given I am signed in as "Micah"
  
  Scenario: Users should only see assigned clients
    Given the following users exist:
      | login |
      | Michael |
      | Kit |
    And the following clients exist:
      | name |
      | cheapbowlingballs.com |
      | bossanova |
      | g2a |
      | fashions weekly |
    And the user "Micah" has the following pacts:
      | client |
      | cheapbowlingballs.com |
      | bossanova |
    And the user "Michael" has the following pacts:
      | client |
      | g2a |
      | bossanova |
    And the user "Kit" has the following pacts:
      | client |
      | fashions weekly |
      
    And I am on "/"
    Then I should see "cheapbowlingballs.com"
    And I should see "bossanova"
    And I should not see "g2a"
    And I should not see "fashions weekly"
