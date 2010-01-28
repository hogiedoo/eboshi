Feature: Make arbitrary payments on an invoice

  Scenario: User logs a partial payment
    Given I am signed in as "Micah"
    And a client exists with name: "bossanova"
    And the user "Micah" is assigned to "bossanova"
    And an invoice exists for "bossanova"
    And I visit the new payment page for that invoice
    And I fill in "Total" with "0.01"
    And I press "Create"
    Then I should see "$0.01 paid"
