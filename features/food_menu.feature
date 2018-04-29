Feature: food_menu

  Scenario: Logged out food menu
    Given I am on the homedef page
    Then I should see "Pork pie"

  Scenario: Sides
    Given I am on the homedef page
    When I follow "Sides" within "body"
    Then I should see "Mash"

  Scenario: Soft drinks
    Given I am on the homedef page
    When I follow "Soft drinks" within "body"
    Then I should see "Coke"

  Scenario: Milkshakes
    Given I am on the homedef page
    When I follow "Milkshakes" within "body"
    Then I should see "Strawberry milkshake"

  Scenario: Alcohol
    Given I am on the homedef page
    When I follow "Alcohol" within "body"
    Then I should see "Lager"

  Scenario: Special Conditions
    Given I am on the homedef page
    When I follow "Special Conditions" within "body"
    Then I should see "Gluten free"
