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