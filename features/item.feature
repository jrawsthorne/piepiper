Feature: Item

Scenario: Make a pie
  Given I am on the items page
  When I fill in "name" with "Pie"
  When I fill in "price" with a "10" within "price"
  When I check "Vegan" within "Vegan"
  When I check "Pie" within "type"
  When I check "Sheffield" within "locations[]"
  When I press "Create" within ".btn btn-primary"
  When I go to the homedef page
  Then I should see "pie" within "body"
