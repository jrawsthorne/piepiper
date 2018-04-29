Feature: Items

Scenario: Create an item
  Given I am on the items page
  When I fill in "name" with "Pie"
  When I fill in "price" with 10 within "price"
  When I check "Vegan" within "speccond"
  When I check "Pie" within "type"
  When I check "Sheffield" within "locations[]"
  When I press "Create" within ".btn btn-primary"
  Then I should be on homedef page
  Then I should see "pie" within "body"

  Scenario: Edin an item
    Given I am on the homedef page
    When I press "edit" within "body"
    When I fill in "name" with "Pie"
    When I fill in "price" with "10" within "price"
    When I check "Vegan" within "speccond"
    When I check "Pie" within "type"
    When I check "Sheffield" within "locations[]"
    When I press "Create" within ".btn btn-primary"
    Then I should be on homedef page
    Then I should see "pie" within "body"
