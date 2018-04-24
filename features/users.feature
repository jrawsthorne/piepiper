Feature: Users pages

  Scenario: Individual user page
    Given I am on the login page
    When I fill in "username" with "admin"
    When I fill in "password" with "admin"
    When I press "Login" within "form"
    When I go to the individual_users page
    Then I should see "User orders"