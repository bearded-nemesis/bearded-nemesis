require 'capybara/cucumber'

Given /^I am on the signup page$/ do
  visit new_user_registration_path
end

Given /^I register a user$/ do
  fill_in 'Email', with: 'chump@chumpsalot.com'
  fill_in 'user[password]', with: "password"
  fill_in 'user[password_confirmation]', with: "password"
  click_button 'Sign up'
end
