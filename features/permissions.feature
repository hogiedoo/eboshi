Feature: User permissions
  Background:
    Given I am signed in as "Micah"
    And there is a client named "fashions weekly"

  Scenario: Users shouldnt be able to access unassigned clients
    Then visiting the invoices page for "fashions weekly" should return 404
    
  Scenario: Users shouldnt be able to access unassigned invoices
    Given an invoice exists for "fashions weekly"
    Then visiting that invoice page should return 404

  Scenario: Users shouldnt be able to access unassigned line items
    Given an adjustment exists for "fashions weekly"
    Then visiting that line item page should return 404

  Scenario: Users shouldnt be able to access unassigned payments
    Given an invoice exists for "fashions weekly"
    Then visiting the new payment page for that invoice should return 404
