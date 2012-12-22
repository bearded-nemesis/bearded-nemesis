Feature: Registering users
  In order to use the site
  I want to register as a user

  Scenario: Email address is not on the whitelist
    Given I am on the signup page
    When I register a user
    Then I should see "Email is not on our invitation list"

  Scenario: Email address is on whitelist
    Given the email is on the whitelist
    And I am on the signup page
    When I register a user
    Then I should see "Logout"