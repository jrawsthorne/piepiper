Feature: orders
  
  Scenario: Logged out and try to access orders page
    When I go to the orders page
    Then I should be on the login page
    
  Scenario: Logged in and try to access orders page
    Given I am on the login page
    When I fill in "username" with "username"
    When I fill in "password" with "password"
    When I press "Login" within "form"
    When I go to the orders page
    Then I should be on the orders page
    
  Scenario: New order success
    Given I am on the login page
    When I fill in "username" with "username"
    When I fill in "password" with "password"
    When I press "Login" within "form"
    When I go to the new_order page
    When I fill in "item[]" with "Apple pie"
    When I fill in "quantity[]" with "1"
    When I press "Create" within "form"
    Then I should see "added successfully"
    
  Scenario: Delete order success
    Given I am on the login page
    When I fill in "username" with "username"
    When I fill in "password" with "password"
    When I press "Login" within "form"
    When I go to the orders page
    When I follow "Delete"
    Then I should see "deleted successfully"
    
  Scenario: New order tweet doesn't exist
    Given I am on the login page
    When I fill in "username" with "username"
    When I fill in "password" with "password"
    When I press "Login" within "form"
    When I go to the new_order_not_tweet page
    Then I should see "That tweet doesn't exist."