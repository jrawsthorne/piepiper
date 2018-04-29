Feature: Campaigns

  Scenario: Creating a campaign
    Given I am on the login page
    When I fill in "username" with "admin"
    When I fill in "password" with "admin"
    When I press "Login" within "form"
    When I follow "Campaigns" within "body"
    When I follow "New campaign" within "body"
    When I fill in "message" with "message"
    When I fill in "winner_number" with "0"
    When I select "10% Discount" from "reward"
    When I press "new_campaign_submit"
    Then I should be on the all_campaigns page
    Then I should see "Win Number"
    
  Scenario: Closing a campaign
    Given I am on the login page
    When I fill in "username" with "admin"
    When I fill in "password" with "admin"
    When I press "Login" within "form"
    When I follow "Campaigns" within "body"
    When I press "Close Campaign"
    Then I should not see "message"
   
    