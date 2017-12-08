Given /^a user with username "([^\"]*)" and email "([^\"]*)" and password "([^\"]*)" and phone number "([^\"]*)"$/ do |username, email, password, phone_number|
  Manager.create(:name => username, :email => email,:password => password,:phone_number => phone_number )
end
Given /^I am signed in with email "([^\"]*)" and password "([^\"]*)"$/ do |email, password|
  self.use_transactional_fixtures = false
  visit '/signin'
  fill_in("email", :with => email)
  fill_in("password", :with => password)
  click_button("Log in")
end
When /^I sign in as "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  self.use_transactional_fixtures = false
  fill_in("email", :with => email)
  fill_in("password", :with => password)
  click_button("Log in")
end
Then /^user "([^\"]*)" should exist$/ do |username|
  @search=Manager.find_by_username(username)
  assert @search != nil
end
Then /^user "([^\"]*)" should not exist$/ do |username|
  @search=Manager.find_by_username(username)
  assert @search == nil
end