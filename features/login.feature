Feature: Login

Background:
    Given a user "rohit" with password "123" exists

Scenario: Successful login

    Given I am on the login page
    When I input username "rohit"
    And I input password "123"
    And I log in
    Then I should be on dashboard

Scenario: Wrong password

    Given I am on the login page
    When I input username "rohit"
    And I input password "1234"
    And I log in
    Then I should be on the login page 