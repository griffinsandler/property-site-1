Feature: Landlord can manually add a property

Scenario: Add a property
Given I am on the properties page
When I follow "create"
Then I am on the Create New Property page
When I press “Save Changes”
Then I should be back on the properties page
And I should see “Griffin’s House”