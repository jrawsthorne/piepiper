Feature: orders
  
  Scenario: Logged out and try to access orders page
    When I go to the orders page
    Then I should be on the login page
    
  Scenario: Logged in and try to access orders page - admin
    Given I am on the login page
    When I fill in "username" with "admin"
    When I fill in "password" with "admin"
    When I press "Login" within "form"
    When I follow "Orders" within "body"
    Then I should be on the orders_norm page
    
  Scenario: Logged in and try to access orders page - order_handler
    Given I am on the login page
    When I fill in "username" with "order_handler"
    When I fill in "password" with "order_handler"
    When I press "Login" within "form"
    When I follow "Orders" within "body"
    Then I should be on the orders_norm page 
    
  Scenario: New order 
    Given I am on the login page
    When I fill in "username" with "order_handler"
    When I fill in "password" with "order_handler"
    When I press "Login" within "form"
    When I go to the new_order page
    Then I should see "Not yet created"  
    
  Scenario: New order success
    Given I am on the login page
    When I fill in "username" with "admin"
    When I fill in "password" with "admin"
    When I press "Login" within "form"
    When I go to the new_order page
    When I fill in "item[]" with "Lager"
    When I press "submit_order"
    Then I should be on the orders_norm page
    Then I should see "added successfully" within "body"
    
    Scenario: Delete order success
   Given I am on the login page
   When I fill in "username" with "admin"
   When I fill in "password" with "admin"
   When I press "Login" within "form"
   When I go to the orders_norm page
   When I follow "Delete"
   Then I should be on the orders_norm page
   Then I should see "deleted successfully" within "body"
  
    
  Scenario: New order tweet doesn't exist
    Given I am on the login page
    When I fill in "username" with "admin"
    When I fill in "password" with "admin"
    When I press "Login" within "form"
    When I go to the new_order_not_tweet page
    Then I should see "That tweet doesn't exist."