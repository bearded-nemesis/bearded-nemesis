Feature: Owning songs
  In order to create play lists
  As a user
  I want to mark which songs I own

  Background:
    Given the following users
      | email             |
      | me@example.com    |
    And the following songs
      | name     | artist   |
      | Foo      | The Foos |
      | Bar      | The Bars |

  @javascript
  Scenario: Marking a song as owned
    Given I am logged in as "me@example.com"
    And I am on the song list page
    When I mark the song "Foo" as owned
    Then song "Foo" should be owned by me
    When I am on my song list page
    Then I should see "Foo"

  @javascript
  Scenario: Marking a song as no longer owned
    Given I am logged in as "me@example.com"
    And I own song "Bar"
    And I am on the song list page
    When I mark the song "Bar" as not owned
    Then song "Bar" should not be owned by me
    When I am on my song list page
    Then I should not see "Bar"
