Feature: Sidebar should include a summary of user activity

  Scenario: A user views the month summary in the sidebar
    Given I am signed in as "Micah"
    And a client exists with name: "bossanova"
    And the user "Micah" is assigned to "bossanova"

    And today is "1983-02-02"
    And I worked 4 hours for "bossanova" today

    And today is "1983-06-19"
    And I worked 3 hours for "bossanova" today

    And today is "1983-06-20"
    And I worked 2 hours for "bossanova" today

    And today is "1983-06-26"
    And I worked 1 hours for "bossanova" today

    And today is "1983-06-20"
    And I am on the invoices page for "bossanova"

    Then I should see "10 hours" next to "Year"
    And I should see "$500.00" next to "Year"

    And I should see "6 hours" next to "Month"
    And I should see "$300.00" next to "Month"

    And I should see "5 hours" next to "Week"
    And I should see "$250.00" next to "Week"

    And I should see "2 hours" next to "Day"
    And I should see "$100.00" next to "Day"
