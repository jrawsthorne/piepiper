Feature: Regular pages

  Scenario: 404 error
    When I go to the page_does_not_exist page
    Then I should be on the home page
  
  Scenario: About page
    Given I am on the about page
    Then I should see "We are Pie Piper"
    
  Scenario: Menu page
    Given I am on the homedef page
    Then I should see "Food Menu"
    
  Scenario: Logo 
    Given I am on the login page
    When I follow "The Pie Piper" within "nav"
    Then I should be on the home page
    
  Scenario: Login page
    Given I am on the login page
    Then I should see "Login"
    
  Scenario: Order page through admin
    Given I am on the login page
    When I fill in "username" with "admin"
    When I fill in "password" with "admin"
    When I press "Login" within "form"
    When I go to the orders page
    Then I should see "Incoming tweets"  
    
  Scenario: Order page through order handler
    Given I am on the login page
    When I fill in "username" with "order_handler"
    When I fill in "password" with "order_handler"
    When I press "Login" within "form"
    Then I should see "Orders" within "body"
    When I go to the orders page
    Then I should see "Incoming tweets" 
    
  Scenario: New Campaigns page
    Given I am on the login page
    When I fill in "username" with "admin"
    When I fill in "password" with "admin"
    When I press "Login" within "form"
    When I go to the new_campaigns page
    Then I should see "New Marketing Campaign"
    
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
    
  Scenario: Items page
    Given I am on the login page
    When I fill in "username" with "admin"
    When I fill in "password" with "admin"
    When I press "Login" within "form"
    When I go to the items page
    Then I should see "Create"  