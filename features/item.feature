Feature: Items

Scenario: Create an item
  Given I am on the login page
  When I fill in "username" with "admin"
  When I fill in "password" with "admin"
  When I press "Login" within "form"
  When I go to the homedef page
  When I follow "New Item" within "body"
  Then I should see "New Item" 
  When I fill in "name" with "Pie"
  When I fill in "price" with "10"
  When I choose "Vegan" within "#special_cond_form"
  When I choose "Pie" within "#item_type_form"
  When I check "Sheffield" within "#location_form"
  When I press "Create"
  Then I should be on the home page
  Then I should see "Pie" within "body"

 