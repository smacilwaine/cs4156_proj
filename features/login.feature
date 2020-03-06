Feature: Login

    As a logged in user
    So I can use the system
    I want to log in successfully

Scenario: Successful login

    Given I am on the login page
    When I input username "Rohit"
    And I input password "123"
    Then I should be logged in
    And I should see "Rohit's Dashboard"
