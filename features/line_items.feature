Feature: Manage line items to contruct invoices

  Background: User logs in
    Given I am signed in as "Micah"
    And there is a client named "bossanova"
    And the user "Micah" is assigned to "bossanova"
    And I am on the invoices page for "bossanova"
  
  Scenario: No create invoice button when no line items
    Then I should not see "Create Invoice"
  
  Scenario: User creates new time item    
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
    
  Scenario: User creates new flat fee
    When I follow "New Flat Fee"
    And I fill in "Amount" with "300"
    And I fill in "Notes" with "testing new flat fee"
    And I press "Create"
    Then I should see "testing new flat fee"
    And I should see "$300.00"
    
#  Scenario: User merges two time items
#    When I follow "New Time Item"
#    And I select "1pm" as the "Start" date and time
#    And I select "3pm" as the "End" date and time
#    And I fill in "Rate" with "75"
#    And I fill in "Notes" with "new time item."
#    And I press "Create"
#    
#    And I follow "New Time Item"
#    And I select "6pm" as the "Start" date and time
#    And I select "7pm" as the "End" date and time
#    And I fill in "Rate" with "75"
#    And I fill in "Notes" with "and another!"
#    And I press "Create"
#    
#    And I check all time items
#    And I follow "Merge"
#    Then I should see "new time item. and another!"
#    And I should see "3.00"
#    And I should see "$225.00"    

