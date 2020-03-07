require 'uri'
require 'cgi'
require 'capybara/rspec'

Given /a user "(.*)" with password "(.*)" exists/ do |user, pass|
	user1 = User.create(username: user, password: pass)
	user1.save
end

Given /I am on the login page/ do 
	visit(login_path)
end

When /^I input username (.*)/ do |username|
	fill_in('username', with: username)
end

When /^I input password (.*)/ do |password|
	fill_in('password', with: username)
end

When /^I log in/ do
	click_button('Login')
end

Then /^I should be on dashboard/ do 
	current_path.should == dashboard_path
end
		
Then /^I should be on the login page/ do 
	current_path.should == login_path
end

