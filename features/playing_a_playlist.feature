Feature: Plyaing a playlist
  In order to rate songs as I'm playing a playlist
  As an user
  I want to go through each song in a mobile friendly way

  Background:
    Given there are 4 songs
    And I own the following songs
      | name    |
      | Song 1  |
      | Song 2  |
      | Song 3  |
    And the following playlists
      | name      |
      | Sample    |
      | Sample 2  |
    And the following songs are in playlist "Sample"
      | name    | me        |
      | Song 1  | pro_drums |
      | Song 3  | pro_drums |
    And the following songs are in playlist "Sample 2"
      | name    | me        |
      | Song 1  |           |
      | Song 3  | pro_drums |
    And I am logged in

  @user
  @javascript
  Scenario: Playing a playlist
    Given I am on the details page for playlist "Sample"
    And I click "Play" within the content
    Then I should see "Song 1"
    When I give a 4 star rating
    And I click "Next"
    And I give a 2 star rating
    And I click "Finish"
    Then I should see "Details"
    And my rating for "pro_drums" on "Song 1" should be 4
    And I should not have a rating for "pro_drums" on "Song 2"
    And my rating for "pro_drums" on "Song 3" should be 2

  @user
  @javascript
  Scenario: Linking to song while playing
    Given I am on the details page for playlist "Sample"
    And I click "Play" within the content
    When I click "Song 1"
    Then I should see "Pro Bass difficulty"

  @user
  @javascript
  Scenario: Playing a playlist with existing ratings
    Given I am on the details page for playlist "Sample"
    And I have rated the following songs
      | name    | instrument | rating |
      | Song 1  | pro_drums  | 3      |
      | Song 3  | pro_drums  | 1      |
    And I click "Play" within the content
    Then I should see "Song 1"
    Then the performance song rating should be 3
    And I click "Next"
    Then the performance song rating should be 1
    And I give a 2 star rating
    And I click "Finish"
    Then I should see "Details"
    And my rating for "pro_drums" on "Song 3" should be 2

    @user
    @javascript
    Scenario: Playing a playlist with sitting out one song
      Given I am on the details page for playlist "Sample 2"
      When I click "Play" within the content
      Then I should see "Song 3"
