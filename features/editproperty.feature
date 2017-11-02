Feature: Landlord can manually change a property

Scenario: Edit a property
Given I am on the properties page
When I follow "Edit" within "proptable"
Then I should be on the Edit Property page
When I fill in “Name” with “Jeff’s house”
And I press “Save Changes”
Then I should be back on the landlord property page
And I should see “Jeff’s House”
