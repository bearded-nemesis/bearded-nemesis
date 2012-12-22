require 'spec_helper'

describe User do
  it "should not allow friends to be added twice" do
    Admin::Whitelist.create! email: "me@example.com"
    Admin::Whitelist.create! email: "you@example.com"
    first_user = User.create! email: "me@example.com",
                              password: "password"
    second_user = User.create! email: "you@example.com",
                               password: "password"

    first_user.friends << second_user
    first_user.save!
    first_user.reload

    first_user.friends << second_user
    first_user.save!
    first_user.reload

    first_user.friends.count.should eq(1)
  end
end