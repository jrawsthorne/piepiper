Feature: login
  
  Scenario: Incorrect password
    Given I am on the login page
    When I fill in "username" with "admin"
    When I fill in "password" with "wrong"
    When I press "Login" within "form"
    Then I should be on the login page
    Then I should see "Incorrect credentials"
    
  Scenario: Incorrect username
    Given I am on the login page
    When I fill in "username" with "wrong"
    When I fill in "password" with "admin"
    When I press "Login" within "form"
    Then I should be on the login page
    Then I should see "Incorrect credentials"
    
  Scenario: Blank username
    Given I am on the login page
    When I fill in "username" with ""
    When I fill in "password" with "admin"
    When I press "Login" within "form"
    Then I should be on the login page
    Then I should see "Incorrect credentials"
    
  
    