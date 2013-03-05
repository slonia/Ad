Feature: Access page

    Scenario: Unauthorized user can't create ad
      Given I am not logged in
      When I create ad
      Then I should see a access denied message

    Scenario: Authorized user (not admin) can create ad
      Given I am logged in
        And I am user
      When I create ad
      Then I should see ad form
