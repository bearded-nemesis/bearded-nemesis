require 'spec_helper'

describe "playlists/index" do
  before(:each) do
    assign(:playlists, [
      stub_model(Playlist,
        :name => "Name",
        :user => nil,
        :amount_of_songs => 1,
        :include_unrated_songs => false,
        :unrated_songs_rating => 2
      ),
      stub_model(Playlist,
        :name => "Name",
        :user => nil,
        :amount_of_songs => 1,
        :include_unrated_songs => false,
        :unrated_songs_rating => 2
      )
    ])
  end

  it "renders a list of playlists" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
