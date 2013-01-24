Before do
  # We need to make sure all sequences get reset
  FactoryGirl.reload
end

Before '@user' do
  @current_user = FactoryGirl.create :user
end