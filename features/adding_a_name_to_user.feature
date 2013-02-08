Feature: Adding a name to users
  In order to be more visible to my friends
  I want to add my name to my account

  @user
  Scenario: Adding a name to a user that doesn't have one
    Given I am logged in
    And I am on my user edit page
    When I enter the following information
      | field | value      |
      | Name  | Mr. Stonks |
    And I click "Save"
    Then I should see "Friends"
    Then I should see "Mr. Stonks"
