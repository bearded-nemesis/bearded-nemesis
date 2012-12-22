Feature: Adding friends
  In order to have rock parties
  As a user
  I want to add friends

  Background:
    Given the following users
      | email             |
      | me@example.com    |
      | other@example.com |
      | third@example.com |

  Scenario: Adding user as a friend
    Given I am logged in as "me@example.com"
    And I am on the user list page
    When I add "other@example.com" as a friend
    And I am on my details page
    Then I should see "other@example.com"

  Scenario: Cannot add a friend twice
    Given I am logged in as "me@example.com"
    And I am on the user list page
    When I add "other@example.com" as a friend
    Then I should not see the add friend link for "other@example.com"