require 'spec_helper'

describe "playlists/edit" do
  before(:each) do
    @playlist = assign(:playlist, stub_model(Playlist,
      :name => "MyString",
      :user => nil,
      :amount_of_songs => 1,
      :include_unrated_songs => false,
      :unrated_songs_rating => 1
    ))
  end

  it "renders the edit playlist form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => playlists_path(@playlist), :method => "post" do
      assert_select "input#playlist_name", :name => "playlist[name]"
      assert_select "input#playlist_user", :name => "playlist[user]"
      assert_select "input#playlist_amount_of_songs", :name => "playlist[amount_of_songs]"
      assert_select "input#playlist_include_unrated_songs", :name => "playlist[include_unrated_songs]"
      assert_select "input#playlist_unrated_songs_rating", :name => "playlist[unrated_songs_rating]"
    end
  end
end
