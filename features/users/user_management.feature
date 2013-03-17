Feature: Create and edit users

  Scenario: User can edit self
    Given I am logged as user
    When I open my edit page
    Then I should see an edit form

  Scenario: Admin can edit self
    Given I am logged as admin
    When I open my edit page
    Then I should see an edit form

  Scenario: Admin can edit user
    Given I am logged as admin
    When I open other user edit page
    Then I should see change role select

  Scenario: Admin can create user
    Given I am logged as admin
    When I open new user page
    Then I should see sign up form

  Scenario: Guest cannot create user
    Given I am not logged in
    When I open new user page
    Then I should see an access denied message

  Scenario: User cannot create user
    Given I am logged as user
    When I open new user page
    Then I should see an access denied message
