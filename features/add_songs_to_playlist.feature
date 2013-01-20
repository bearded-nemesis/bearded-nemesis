Feature: Adding songs to playlists
  In order to make playlists useful
  As an user
  I want to add songs to a playlist

  Background:
    Given there are 15 songs
    And I own the following songs
      | name    |
      | Song 3  |
      | Song 5  |
      | Song 10 |
      | Song 12 |
      | Song 13 |
    And I have rated the following songs
      | name    | instrument | rating |
      | Song 2  | bass       | 3      |
      | Song 3  | bass       | 1      |
      | Song 5  | drums      | 5      |
      | Song 10 | bass       | 4      |
      | Song 12 | bass       | 2      |
    And the following playlists
      | name      |
      | Sample    |
    And I am logged in

  @user
  Scenario: Auto adding songs for one user
    Given I am on the details page for playlist "Sample"
    And I click "Auto-add songs"
    And I enter the following information
      | Song count |
      | 2          |
    And I choose the following instruments for each player
      | user | instrument |
      | me   | bass       |
    And I click "Add songs"
    Then I should see "Song 10"
    And I should see "Song 5"
    And I should not see "Song 3"
    And I should not see "Song 2"
    And I should not see "Song 12"
    And I should not see "Song 13"

  @user
  Scenario: Auto adding songs excluding non-rated songs
    Given I am on the details page for playlist "Sample"
    And I click "Auto-add songs"
    And I enter the following information
      | Song count |
      | 2          |
    And I uncheck "Include unrated"
    And I choose the following instruments for each player
      | user | instrument |
      | me   | bass       |
    And I click "Add songs"
    Then I should see "Song 10"
    And I should see "Song 12"
    And I should not see "Song 3"
    And I should not see "Song 2"
    And I should not see "Song 5"
    And I should not see "Song 13"

  @user
  Scenario: Don't include songs that are already in the playlist
    Given playlist "Sample" has the following songs
      | song    |
      | Song 12 |
    And I am on the details page for playlist "Sample"
    And I click "Auto-add songs"
    And I enter the following information
      | Song count |
      | 2          |
    And I uncheck "Include unrated"
    And I choose the following instruments for each player
      | user | instrument |
      | me   | bass       |
    And I click "Add songs"
    Then I should see "Song 10"
    And I should see "Song 12"
    And I should see "Song 3"
    And I should not see "Song 2"
    And I should not see "Song 5"
    And I should not see "Song 13"