When /^I am on the user page for "(.*?)"$/ do |email|
  user = User.find_by_email email
  visit user_path(user)
end

Given /^I have the following friends$/ do |friends|
  friends.hashes.each do |friend|
    friend = User.find_by_email friend["email"]
    @current_user.friends << friend
  end

  @current_user.save!
end

Given /^I am on my user page$/ do
  visit user_path(@current_user)
end

Given /^I am on my user edit page$/ do
  visit edit_user_path(@current_user)
end