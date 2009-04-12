Feature: Manage line items to contruct invoices

  Scenario: User clocks in
    Given I am signed in as "Micah"
    And there is a client named "bossanova"
    And the user "Micah" is assigned to "bossanova"
    And I am on the invoices page for "bossanova"
    Then I should not see "Create Invoice"
    
    When I follow "New Time Item"
    And I select "1pm" as the "Start" date and time
    And I select "3pm" as the "End" date and time
    And I fill in "Rate" with "75"
    And I fill in "Notes" with "testing new time item"
    And I press "Create"
    Then I should see "testing new time item"
    And I should see "2.00"
    And I should see "$75/hr"
    And I should see "$150.00"
