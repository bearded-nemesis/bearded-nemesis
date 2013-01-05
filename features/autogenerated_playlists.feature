Feature: Auto generate playlists
  In order to have the most fun
  As an user
  I want the system to create an optimal playlist

  Background:
    Given the following users
      | email            |
      | user@example.com |
      | foo@example.com  |
      | bar@example.com  |
    And 100 random songs
    And all the songs have random ratings

  Scenario: Auto-generating a basic playlist
    Given I am logged in as "user@example.com"
    And I own all the songs
    And I have the following friends
      | email            |
      | foo@example.com  |
      | bar@example.com  |
    And I am on the playlist list page
    When I click "Generate Playlist"
    And I enter the following information
      | Field           | Value            |
      | Name            | Foo Playlist     |
      | Amount of songs | 15               |
      | Owner           | user@example.com |
      | Bass            | user@example.com |
      | Guitar          | foo@example.com  |
      | Drums           | bar@example.com  |
    And I click "Generate"
    And I am on the playlist list page
    Then I should see "Foo Playlist"
    And I should see "15"
