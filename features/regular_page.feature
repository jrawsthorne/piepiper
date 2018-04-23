Feature: regular pages

  Scenario: 404 error
    When I go to the page_does_not_exist page
    Then I should be on the home page
  
  Scenario: About page
    Given I am on the about page
    Then I should see "We are Pie Piper"