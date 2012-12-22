Given /^I am on the user list page$/ do
  visit users_path
end

When /^I add "(.*?)" as a friend$/ do |email|
  user_id = User.find_by_email(email).id
  link = find :css, "a[data-user-id='#{user_id}']"
  link.click
end

When /^I am on my details page$/ do
  visit user_path(@current_user)
end
