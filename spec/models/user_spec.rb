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

  describe "display name" do
    it "should show the name if it exists" do
      user = User.new email: "foo@example.com"
      user.name = "Mr. Sinister"
      user.display_name.should eq("Mr. Sinister (foo@example.com)")
    end

    it "should show only email if name isn't set" do
      user = User.new email: "foo@example.com"
      user.display_name.should eq("foo@example.com")
    end
  end
end