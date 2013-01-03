require 'spec_helper'

describe "playlists/show" do
  before(:each) do
    @playlist = assign(:playlist, stub_model(Playlist,
      :name => "Name",
      :user => nil,
      :amount_of_songs => 1,
      :include_unrated_songs => false,
      :unrated_songs_rating => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(//)
    rendered.should match(/1/)
    rendered.should match(/false/)
    rendered.should match(/2/)
  end
end
