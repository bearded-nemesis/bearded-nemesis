Feature: Manage playlists
  In order to work with playlists
  As an user
  I want to manage available playlists

  Background:
    Given the following users
      | email            |
      | user@example.com |
    And the following playlists
      | name      |
      | Dummy     |
      | Delete Me |

  Scenario: Adding a new playlist
    Given I am logged in as "user@example.com"
    And I am on the playlist list page
    When I click "New Playlist"
    And I enter the following information
      | Name         | Amount of songs |
      | Foo Playlist | 5               |
    And I click "Save"
    And I am on the playlist list page
    Then I should see "Foo Playlist"
    And I should see "5"

  Scenario: Removing a playlist
    Given I am logged in as "user@example.com"
    And I am on the playlist list page
    When I remove playlist "Delete Me"
    And I am on the playlist list page
    Then I should not see "Delete Me"