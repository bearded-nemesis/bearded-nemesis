Then /^the performance song rating should be (\d)$/ do |rating|
  find("#rating_#{rating}").selected?.should be_true
end