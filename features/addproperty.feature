Feature: Landlord can manually add a property

Scenario: Add a property (happy)
Given a user with username "Griffin" and email "gsandler@tulane.edu" and password "password" and phone number "2038042325"
Given I am on the Login page
When I sign in as "gsandler@tulane.edu" with password "password"
Then I should be on the manager profile page
When I follow "My Properties"
And I follow "Create New"
Then I am on the Create New Property page
When I fill in the form correctly
Then I am on the Properties page
And I should see "Griffin's House"


Scenario: Add a property (sad)
Given a user with username "Griffin" and email "gsandler@tulane.edu" and password "password" and phone number "2038042325"
Given I am on the Login page
When I sign in as "gsandler@tulane.edu" with password "password"
Then I should be on the manager profile page
When I follow "My Properties"
And I follow "Create New"
Then I am on the Create New Property page
When I fill in the form incorrectly
Then I am on the Properties page
And I should not see "Griffin's House"