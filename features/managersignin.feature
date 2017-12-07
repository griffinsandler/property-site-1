Feature: Manager can login to Abode


Scenario: Manager logs in (happy path)
    Given a user with username "Griffin" and email "gsandler@tulane.edu" and password "password" and phone number "2038042325"
    Given I am on the Login page
    When I sign in as "gsandler@tulane.edu" with password "password"
    Then I should be on the manager profile page

  
Scenario: User fails to log in because of lack of @ symbol (sad path)
    Given a user with username "Griffin" and email "gsandler@tulane.edu" and password "password" and phone number "2038042325"
    Given I am on the Login page
    When I sign in as "gsandlertulane.edu" with password "password"
    Then I should be on the Local Signup page
