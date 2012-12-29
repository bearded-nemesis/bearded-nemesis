Then /^I should see "(.*?)"$/ do |arg1|
  page.should have_content(arg1)
end

Then /^I should not see "(.*?)"$/ do |arg1|
  page.should_not have_content(arg1)
end

Given /^the following users$/ do |users|
  users.hashes.each do |item|
    Admin::Whitelist.create! email: item["email"]
    User.create! item.merge(password: "password",
                            password_confirmation: "password")
  end
end

Given /^I am logged in as "(.*?)"$/ do |email|
  visit new_user_session_path
  fill_in 'Email', with: email
  fill_in 'Password', with: "password"
  click_button 'Sign in'

  @current_user = User.find_by_email email
end

When /^I click "(.*?)"$/ do |text|
  click_link_or_button text
end

When /^I enter the following information$/ do |table|
  table.hashes.each do |item|
    table.headers.each do |element|
      fill_in element, with: item[element]
    end
  end
end
