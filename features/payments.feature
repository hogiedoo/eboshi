Feature: Make arbitrary payments on an invoice

  Scenario: User logs a partial payment
    Given I am signed in as "Micah"
    And the following clients exist:
      | name |
      | bossanova |
    And the user "Micah" has the following assignments:
      | client |
      | bossanova |
    And an invoice exists for "bossanova"
    And I visit the new payment page for that invoice
    And I fill in "Total" with "0.01"
    And I press "Create"
    Then I should see "$0.01 paid"
