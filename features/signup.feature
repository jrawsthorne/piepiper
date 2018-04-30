Feature: Signup

  Scenario: Signing up
    Given I am on the signup page
    When I fill in "username" with "abc" 
    When I fill in "password" with "password"
    When I fill in "passwordconf" with "password"
    When I fill in "firstname" with "Abc"
    When I fill in "surname" with "Def"
    When I fill in "email" with "abcDef@gmail.com"
    When I fill in "address" with "Carrysbrook Court, Sheffield, UK" within ".form-control"
    When I fill in "house" with "4X23" within ".form-control"
    When I fill in "street_address" with "7 Oakholme Road" within ".form-control"
    When I fill in "postal_code" with "S10 2AD" within ".form-control"
    When I press "Save changes" within ".form-control"
    When I check "Vegetarian" within ".form-group"
    When I press "Signup" within ".form-group"
    Then I should see "Food Menu"