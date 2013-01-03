require 'spec_helper'

describe "playlists/index" do
  before(:each) do
    assign(:playlists, [
      stub_model(Playlist,
        :name => "",
        :user => "",
        :amountOfSongs => "",
        :includeUnratedSongs => "",
        :unratedSongsRating => ""
      ),
      stub_model(Playlist,
        :name => "",
        :user => "",
        :amountOfSongs => "",
        :includeUnratedSongs => "",
        :unratedSongsRating => ""
      )
    ])
  end

  it "renders a list of playlists" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
