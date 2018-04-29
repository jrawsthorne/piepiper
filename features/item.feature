Feature: Item

Scenario: Make a pie
  Given I am on the items page
  When I fill in "name" with "Pie"
  When I fill in "price" with "10" within "price"
  When I check "speccond" with "Vegan" within ".form-group"
  When I check "type" with "Pie" within ".form-group"
  When I check "locations[]" with "Sheffield" within ".form-group"
  When I press "Create" within ".btn btn-primary"
  When I go to the homedef page
  Then I should see "pie" within "body"
