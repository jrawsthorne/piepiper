Feature: authentication

  Scenario: Logged out and try to access account page
    When I go to the account page
    Then I should be on the login page

  Scenario: Logged in and try to access account page
    Given I am on the login page
    When I fill in "username" with "user"
    When I fill in "password" with "user"
    When I press "Login" within "form"
    When I go to the account page
    Then I should see "Account Settings"

  Scenario: Login takes you to home page
    Given I am on the login page
    When I fill in "username" with "admin"
    When I fill in "password" with "admin"
    When I press "Login" within "form"
    Then I should be on the home page

  Scenario: Logout
    Given I am on the login page
    When I fill in "username" with "admin"
    When I fill in "password" with "admin"
    When I press "Login" within "form"
    When I go to the logout page
    Then I should be on the home page

  Scenario: Incorrect Credentials
    Given I am on the login page
    When I fill in "username" with "admin"
    When I fill in "password" with "wrong"
    When I press "Login" within "form"
    Then I should be on the login page
    Then I should see "Incorrect credentials"

  Scenario: Sign up while logged in
    Given I am on the login page
    When I fill in "username" with "admin"
    When I fill in "password" with "admin"
    When I press "Login" within "form"
    When I go to the signup page
    Then I should be on the account page
