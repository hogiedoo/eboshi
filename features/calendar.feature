Feature: Calendar that shows a summary of hours logged each day
  Background:
    Given I am signed in as "Micah"
    And there is a client named "bossanova"
    And the user "Micah" is assigned to "bossanova"

  Scenario: A user views the month summary in the sidebar
    Given today is "1983-06-19"
    And I worked 13 hours for "bossanova" today
    And I am on the invoices page for "bossanova"
    Then I should see "13 hours" under "This Month"
    And I should see "$650.00" under "This Month"

  Scenario: A user views a calendar
    Given today is "1983-06-19"
    And I worked 13 hours for "bossanova" today
    When I go to /calendar
    Then I should see "13 hours" within ".today"
    And I should see "13 hours" under "Total"
    And I should see "$650.00" under "Total"

  Scenario: A user views a calendar of a specific month
    When I go to /calendar/2009/11
    Then I should see "November"
    And I should not see "0 hours" within ".calendar"
    And I should not see "0.0" within ".calendar"
