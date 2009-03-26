Feature: Manage client-user associations
  Background:
    Given I am signed in as "Micah"
    And the following users exist:
      | login |
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
  
  Scenario: Users should only see assigned clients
    Given I am on "/"
    Then I should see "cheapbowlingballs.com"
    And I should see "bossanova"
    And I should not see "g2a"
    And I should not see "fashions weekly"
    
  Scenario: Users should see collaborators
    Given I am on the invoices page for "bossanova"
    Then I should see "Michael"
    And I should not see "Kit"
    
  Scenario: Users should be able to delete assignments
    Given I am on the invoices page for "bossanova"
    And I click "delete" next to "Michael"
    Then I should not see "Michael"

  Scenario: Users shouldn't be able to access unassigned clients
    Then visiting the invoices page for "fashions weekly" should return 404
    
  Scenario: Users shouldn't be able to access unassigned invoices
    Given an invoice exists for "fashions weekly"
    Then visiting that invoice page should return 404

  Scenario: Users shouldn't be able to access unassigned line items
    Given an adjustment exists for "fashions weekly"
    Then visiting that line item page should return 404

  Scenario: Users shouldn't be able to access unassigned payments
    Given an invoice exists for "fashions weekly"
    Then visiting the new payment page for that invoice should return 404
