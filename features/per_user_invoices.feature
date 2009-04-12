Feature: Invoices should include a users optional customized logo

  Scenario: User uploads a logo and views an invoice
    Given I am signed in as "Micah"
    And there is a client named "bossanova"
    And the user "Micah" is assigned to "bossanova"
    And an invoice exists for "bossanova"
    And I am on "/"
    When I follow "View Account"
    And I upload a logo image
    And I press "Update"
    Then I should see "Account updated"
    When I go to the first invoice for "bossanova"
    Then the logo should be an image

  Scenario: User with no logo views an invoice
    Given I am signed in as "Micah"
    And there is a client named "bossanova"
    And the user "Micah" is assigned to "bossanova"
    And an invoice exists for "bossanova"
    When I go to the first invoice for "bossanova"
    Then the logo should say "Micah"

