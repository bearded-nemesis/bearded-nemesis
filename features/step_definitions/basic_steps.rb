Then /^I should see "(.*?)"$/ do |arg1|
  page.should have_content(arg1)
end

Then /^I should not see "(.*?)"$/ do |arg1|
  page.should_not have_content(arg1)
end

Given /^the following users$/ do |users|
  users.hashes.each do |item|
    FactoryGirl.create :user, item
  end
end

Given /^I am logged in as "(.*?)"$/ do |email|
  log_in email
  @current_user = User.find_by_email email
end

When /^I am logged in$/ do
  log_in @current_user.email
end

When /^I click "(.*?)"$/ do |text|
  click_link_or_button text
end

When /^I click "([^"]*)" within the content$/ do |text|
  within "#main" do
    click_link_or_button text
  end
end

When /^I enter the following information$/ do |table|
  table.hashes.each do |item|
    table.headers.each do |element|
      fill_in element, with: item[element]
    end
  end
end

When /^I select the following values from "([^"]*)"$/ do |selector, table|
  table.hashes.each do |item|
    select item[:value], from: selector
  end
end

When /^I uncheck "([^"]*)"$/ do |selector|
  uncheck selector
end

private

def log_in(email, password = nil)
  visit new_user_session_path
  fill_in 'user_email', with: email
  fill_in 'user_password', with: (password || "password")
  click_button 'Sign in'
end