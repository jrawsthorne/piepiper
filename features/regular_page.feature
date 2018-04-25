Feature: Regular pages

  Scenario: 404 error
    When I go to the page_does_not_exist page
    Then I should be on the home page
  
  Scenario: About page
    Given I am on the about page
    Then I should see "We are Pie Piper"
    
  Scenario: Menu page
    Given I am on the home page
    Then I should see "Food menu"
    
  Scenario: Login page
    Given I am on the login page
    Then I should see "Please sign in"
    
  Scenario: Order page
    Given I am on the login page
    When I fill in "username" with "admin"
    When I fill in "password" with "admin"
    When I press "Login" within "form"
    When I go to the orders page
    Then I should see "Incoming tweets"  
    
  Scenario: New Campaigns page
    Given I am on the login page
    When I fill in "username" with "admin"
    When I fill in "password" with "admin"
    When I press "Login" within "form"
    When I go to the new_campaigns page
    Then I should see "New Marketing Campaigns"
    
  Scenario: All Campaigns page
    Given I am on the login page
    When I fill in "username" with "admin"
    When I fill in "password" with "admin"
    When I press "Login" within "form"
    When I go to the all_campaigns page
    Then I should see "Campaigns"  
    
  Scenario: Users page
    Given I am on the login page
    When I fill in "username" with "admin"
    When I fill in "password" with "admin"
    When I press "Login" within "form"
    When I go to the users page
    Then I should see "Account Type"