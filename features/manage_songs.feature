Feature: Manage songs
  In order to work with songs
  As an administrator
  I want to manage available songs

  Background:
    Given the following users
      | email             | admin |
      | admin@example.com | true  |
      | other@example.com | false |
    And the following songs
      | name      |
      | Dummy     |
      | Delete Me |

  Scenario: Adding a new song
    Given I am logged in as "admin@example.com"
    And I am on the song list page
    When I click "New Song"
    And I enter the following information
      | field     | value      |
      | Name      | Foo2 Song  |
      | Artist    | Foo Artist |
      | Genre     | Foo Genre  |
      | Shortname | foosong    |
    And I click "Save"
    And I am on the song list page
    Then I should see "Foo2 Song"
    And I should see "Foo Artist"

  Scenario: Removing a song
    Given I am logged in as "admin@example.com"
    And I am on the song list page
    When I remove song "Delete Me"
    And I am on the song list page
    Then I should not see "Delete Me"

  Scenario: Non-admin users cannot see manage song links
    Given I am logged in as "other@example.com"
    When I am on the song list page
    Then I should not see "New Song"
    And I should not see "Remove"
    And I should not see "Edit"

  Scenario: Non-admin users cannot edit songs
    Given I am logged in as "other@example.com"
    When I am on the edit page for song "Dummy"
    Then I should not see "Dummy"

  Scenario: Non-admin users cannot create songs
    Given I am logged in as "other@example.com"
    When I am on the new song page
    And I should not see "Name"