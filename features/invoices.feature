Feature: Invoices
  
  Background:
    Given I am signed in as "Micah"
    And there is a client named "bossanova"
    And the user "Micah" is assigned to "bossanova"
    And a time item for "bossanova"
    And a time item for "bossanova"
    And a time item for "bossanova"
    And I am on the invoices page for "bossanova"

  Scenario: User creates an invoice with dates and times
    When I follow "Create Invoice"
    And I fill in "Project Name" with "Testing Invoice"
    And I check "Include dates"
    And I check "Include times"
    And I press "Create"
    And I go to the first invoice for "bossanova"
    Then I should see dates on the invoice
    And I should see times on the invoice

  Scenario: User creates an invoice without dates or time
    When I follow "Create Invoice"
    And I fill in "Project Name" with "Testing Invoice"
    And I uncheck "Include dates"
    And I uncheck "Include times"
    And I press "Create"
    And I go to the first invoice for "bossanova"
    Then I should not see any dates on the invoice
    And I should not see any times on the invoice
