Feature: authentication
  
  Scenario: Logged out and try to access account page
    When I go to the account page
    Then I should be on the login page
    
  Scenario: Logged in and try to access account page
    Given I am on the login page
    When I fill in "username" with "username"
    When I fill in "password" with "password"
    When I press "Login" within "form"
    When I go to the account page
    Then I should see "Account Settings"
    
  Scenario: Login takes you to orders page
    Given I am on the login page
    When I fill in "username" with "username"
    When I fill in "password" with "password"
    When I press "Login" within "form"
    Then I should be on the orders page
    
  Scenario: View users page
    Given I am on the login page
    When I fill in "username" with "username"
    When I fill in "password" with "password"
    When I press "Login" within "form"
    When I go to the users page
    Then I should see "Users"
    
  Scenario: Logout
    Given I am on the login page
    When I fill in "username" with "username"
    When I fill in "password" with "password"
    When I press "Login" within "form"
    When I go to the logout page
    Then I should be on the home page

  Scenario: Sign up while logged in
    Given I am on the login page
    When I fill in "username" with "username"
    When I fill in "password" with "password"
    When I press "Login" within "form"
    When I go to the signup page
    Then I should be on the home page
    
  Scenario: Error when sign up without authenticating with twitter
    When I go to the signup page
    Then I should see "Please sign in with Twitter first"
  