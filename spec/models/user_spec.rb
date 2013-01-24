require 'spec_helper'

describe User do
  it "should not allow friends to be added twice" do
    first_user = FactoryGirl.create :user
    second_user = FactoryGirl.create :user

    first_user.friends << second_user
    first_user.save!
    first_user.reload

    first_user.friends << second_user
    first_user.save!
    first_user.reload

    first_user.friends.count.should eq(1)
  end
end