Feature: Manage playlists
  In order to work with playlists
  As an user
  I want to manage available playlists

  Background:
    Given there are 2 songs
    Given the following playlists
      | name      |
      | Dummy     |
      | Delete Me |
    And I am logged in

  @user
  Scenario: Adding a new playlist
    Given I am on the playlist list page
    When I click "New Playlist"
    And I enter the following information
      | Name         |
      | Foo Playlist |
    And I click "Save"
    And I am on the playlist list page
    Then I should see "Foo Playlist"

  @user
  Scenario: Removing a playlist
    Given I am on the detail page for playlist "Delete Me"
    When I click "Delete"
    And I am on the playlist list page
    Then I should not see "Delete Me"

  @user
  @javascript
  Scenario: Adding a song to a new playlist
    Given I am on the playlist list page
    When I click "New Playlist"
    And I enter the following information
      | Name         |
      | Foo Playlist |
    When I enter the song "Song 1"
    And I click "Save"
    And I am on the detail page for playlist "Foo Playlist"
    Then I should see "Song 1"

  @user
  @javascript
  Scenario: Adding a song to a current playlist
    Given I am on the edit page for playlist "Dummy"
    When I enter the song "Song 1"
    And I click "Save"
    And I am on the detail page for playlist "Dummy"
    Then I should see "Song 1"

  @user
  @javascript
  Scenario: Linking to a song from the playlist details
    Given playlist "Dummy" has the following songs
      | song   |
      | Song 1 |
    And I am on the detail page for playlist "Dummy"
    When I click "Song 1"
    Then I should see "Pro Bass difficulty"

  @user
  @javascript
  Scenario: Cannot add a song to a playlist twice
    Given I am on the edit page for playlist "Dummy"
    When I enter the song "Song 2"
    Then I should not see "Song 2" in autocomplete

  @user
  Scenario: Changing the instrument a user is playing on a song
    Given playlist "Dummy" has the following songs
      | song   |
      | Song 1 |
    And I am on the detail page for playlist "Dummy"
    When I change the select for "Song 1" to "drums"
    Then I should see the "drums" option for "Song 1" selected

  @user
  Scenario: Removing a playlist song
    Given playlist "Dummy" has the following songs
      | song   |
      | Song 1 |
    And I am on the detail page for playlist "Dummy"
    And I click "Remove"
    Then I should not see "Song 1"
