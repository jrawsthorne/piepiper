Feature: Item

Scenario: Make a pie
  Given I am on the items page
  When I fill in "name" with "Pie"
  When I fill in "price" with "10"
  When I check "Vegan" within "speccond"
  When I check "Pie" within "type"
  When I check "Sheffield" within "locations[]"
  When I press "Create" within ".btn btn-primary"
  When I go to the homedef page
  Then I should see "pie" within "body"
