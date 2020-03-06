Feature: Sign Up

    As a logged in user
    So I can use the system
    I want to log in successfully

Scenario: Successful signup (Student)

    Given I am on the signup page
    When I input username "Test_Student"
    And I input email "test@test.com"
    And I input password "123"
    And I input role "Student"
    Then I should be signed up
    And I should see "Test's Dashboard"

Scenario: Successful signup (Instructor)

    Given I am on the signup page
    When I input username "Test_Instructor"
    And I input email "ins@test.com"
    And I input password "123"
    And I input role "Instructor"
    Then I should be signed up
    And I should see "Instructor's Dashboard"

Scenario: Unsuccessful signup (missing username)

    Given I am on the signup page
    When I input username ""
    And I input email "ins@test.com"
    And I input password "123"
    And I input role "Instructor"
    Then I should not be signed up
    And I should not see "Instructor's Dashboard"

Scenario: Unsuccessful signup (incorrect username)

    Given I am on the signup page
    When I input username "Test"
    And I input email "ins@test.com"
    And I input password "123"
    And I input role "Instructor"
    Then I should not be signed up
    And I should not see "Instructor's Dashboard"

Scenario: Unsuccessful signup (missing email)

    Given I am on the signup page
    When I input username "Test_Instructor"
    And I input email ""
    And I input password "123"
    And I input role "Instructor"
    Then I should not be signed up
    And I should not see "Instructor's Dashboard"

Scenario: Unsuccessful signup (incorrect email)

    Given I am on the signup page
    When I input username "Test_Instructor"
    And I input email "ins@test"
    And I input password "123"
    And I input role "Instructor"
    Then I should not be signed up
    And I should not see "Instructor's Dashboard"

Scenario: Unsuccessful signup (missing password)

    Given I am on the signup page
    When I input username "Test_Instructor"
    And I input email "ins@test.com"
    And I input password ""
    And I input role "Instructor"
    Then I should not be signed up
    And I should not see "Instructor's Dashboard"
