Then /^the performance song rating should be (\d)$/ do |rating|
  find("#rating_#{rating}")[:checked].should be_true
end

When /^I give a (\d+) star rating$/ do |rating|
  choose "rating_#{rating}"
end

Then /^I should see the "([^"]*)" option for "([^"]*)" selected$/ do |instrument, song|
  field_labeled("#{User.find(@current_user.id).email}[#{song}]").find(:xpath, "//option[@value = '#{instrument}'][@selected = 'selected']").should be_present
end