Feature: Access page

  Scenario: Unauthorized user can't create ad
    Given I am not logged in
    When I create ad
    Then I should see an access denied message

  Scenario: Authorized user (not admin) can create ad
    Given I am logged as user
    When I create ad
    Then I should see ad form

 Scenario: Admin cannot create ad
   Given I am logged as admin
   When I create ad
   Then I should see an access denied message
