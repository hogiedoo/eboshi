Feature: Should be able to see the user breakdown for each invoice

  Scenario: User views breakdown
    Given I am signed in as "Micah"
    And a user "Michael" exists with name: "Michael"
    And a user "Kit" exists with name: "Kit"
    And a client exists with name: "bossanova"
    And the client "bossanova" has the following assignments:
      | user    |
      | Micah   |
      | Michael |
      | Kit     |
    And 3 unbilled works exist with client: that client, user: user "Micah"
    And 2 unbilled works exist with client: that client, user: user "Michael"
    And a unbilled work exists with client: that client, user: user "Kit"
    And I am on the invoices page for "bossanova"

    Then I should see "$150" next to "Micah"
    And I should see "$100" next to "Michael"
    And I should see "$50" next to "Kit"

    Then I should see "3" next to "Micah"
    And I should see "2" next to "Michael"
    And I should see "1" next to "Kit"
