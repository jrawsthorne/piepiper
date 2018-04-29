Feature: item

Scenario: Make a pie
  Given I am on the items page
  When I fill in "name" with "Pie"
  When I fill in "price" with "10 within "form"
  When I fill in "speccond" with "Vegan"
  When I fill in "type" with "Pie"
  When I fill in "locations[]" with "Sheffield"
  When I press "Create" within "form"
  When I go to the homedef page
  Then I should see "pie" within "body"
