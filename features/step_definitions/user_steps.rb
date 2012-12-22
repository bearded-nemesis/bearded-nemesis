When /^I am on the user page for "(.*?)"$/ do |email|
  user = User.find_by_email email
  visit user_path(user)
end
