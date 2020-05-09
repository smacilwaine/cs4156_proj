require 'uri'
require 'cgi'
require 'capybara/rspec'

module WithinHelpers
    def with_scope(locator)
        locator ? within(locator) { yield } : yield
    end
end
World(WithinHelpers)

# You can implement step definitions for undefined steps with these snippets:

Given /^I am on the signup page$/ do
    visit(new_user_path)
end

When /^I input username on signup "(.*)"$/  do |username|
    fill_in("Username", :with => username)
end

When /^I input email on signup "(.*)"$/ do |email|
    fill_in("Email", :with => email)
end

When /^I input email_confirmation on signup "(.*)"$/ do |email_confirmation|
    fill_in("Email confirmation", :with => email_confirmation)
end

When /^I input password on signup "(.*)"$/ do |password|
    fill_in("Password", :with => password)
end

When /^I input password_confirmation on signup "(.*)"$/ do |password_confirmation|
    fill_in("Password confirmation", :with => password_confirmation)
end

When /^I input role on signup "(.*)"$/ do |role|
    select(role, :from => "Role")
end

When /^I click on "(.*)" in signup$/ do |signup_button|
    click_button(signup_button)
end

Then /^I should be signed up$/ do
    expect(page).to have_current_path(user_index_path)
end

Then /^I should see "(.*)"$/ do |text|
    expect(page).to have_content text
end

Then /^I should not be signed up$/ do
    expect(page).to have_current_path(new_user_path)
end

Then /^I should not see "(.*)"$/ do |text|
    !expect(page).to have_content text
end