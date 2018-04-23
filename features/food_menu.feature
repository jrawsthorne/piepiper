Feature: food_menu
  
  Scenario: Logged out food menu
    Given I am on the homepage
    Then I should see "Pork pie"
    
  Scenario: Sides
    Given I am on the home page
    When I follow "Sides" within "body"
    Then I should see "Mash"
    
  Scenario: Soft drinks
    Given I am on the home page
    When I follow "Soft drinks" within "body"
    Then I should see "Coke"  
    
  