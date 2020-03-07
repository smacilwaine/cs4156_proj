Feature: Sign Up

    As a logged in user
    So I can use the system
    I want to log in successfully

Scenario: Successful signup (Student)

    Given I am on the signup page
    When I input username on signup "Test_Student"
    And I input email on signup "test@test.com"
    And I input password on signup "123"
    And I input role on signup "Student"
    And I click on "Save User" in signup
    Then I should be signed up
    And I should see "Test's Dashboard"

Scenario: Successful signup (Instructor)

    Given I am on the signup page
    When I input username on signup "Test_Instructor"
    And I input email on signup "ins@test.com"
    And I input password on signup "123"
    And I input role on signup "Instructor"
    And I click on "Save User" in signup
    Then I should be signed up
    And I should see "Instructor's Dashboard"

Scenario: Unsuccessful signup (missing username)

    Given I am on the signup page
    When I input username on signup ""
    And I input email on signup "ins@test.com"
    And I input password on signup "123"
    And I input role on signup "Instructor"
    And I click on "Save User" in signup
    Then I should not be signed up
    And I should not see "Instructor's Dashboard"

Scenario: Unsuccessful signup (incorrect username)

    Given I am on the signup page
    When I input username on signup "Test"
    And I input email on signup "ins@test.com"
    And I input password on signup "123"
    And I input role on signup "Instructor"
    And I click on "Save User" in signup
    Then I should not be signed up
    And I should not see "Instructor's Dashboard"

Scenario: Unsuccessful signup (missing email)

    Given I am on the signup page
    When I input username on signup "Test_Instructor"
    And I input email on signup ""
    And I input password on signup "123"
    And I input role on signup "Instructor"
    And I click on "Save User" in signup
    Then I should not be signed up
    And I should not see "Instructor's Dashboard"

Scenario: Unsuccessful signup (incorrect email)

    Given I am on the signup page
    When I input username on signup "Test_Instructor"
    And I input email on signup "ins@test"
    And I input password on signup "123"
    And I input role on signup "Instructor"
    And I click on "Save User" in signup
    Then I should not be signed up
    And I should not see "Instructor's Dashboard"

Scenario: Unsuccessful signup (missing password)

    Given I am on the signup page
    When I input username on signup "Test_Instructor"
    And I input email on signup "ins@test.com"
    And I input password on signup ""
    And I input role on signup "Instructor"
    And I click on "Save User" in signup
    Then I should not be signed up
    And I should not see "Instructor's Dashboard"
