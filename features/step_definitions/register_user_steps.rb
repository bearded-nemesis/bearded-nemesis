require 'capybara/cucumber'

Given /^the email is on the whitelist$/ do
  Admin::Whitelist.create! email: "chump@chumpsalot.com"
end

Given /^I am on the signup page$/ do
  visit new_user_registration_path
end

When /^I register a user$/ do
  fill_in 'Email', with: 'chump@chumpsalot.com'
  fill_in 'user[password]', with: "password"
  fill_in 'user[password_confirmation]', with: "password"
  fill_in 'user[name]', with: "Mr. Foo Bar"
  click_button 'Sign up'
end
