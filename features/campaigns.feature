Feature: Campaigns

  Scenario: Creating a campaign
    Given I am on the login page
    When I fill in "username" with "admin"
    When I fill in "password" with "admin"
    When I press "Login" within "form"
    When I follow "Campaigns" within "body"
    When I follow "New campaign" within "body"
    When I fill in "message" with "message"
    When I press "Create"
    When I go to the all_campaigns page
    Then I should see "Marketing Campaigns"
    