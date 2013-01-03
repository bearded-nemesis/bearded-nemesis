require 'spec_helper'

describe "playlists/edit" do
  before(:each) do
    @playlist = assign(:playlist, stub_model(Playlist,
      :name => "",
      :user => "",
      :amountOfSongs => "",
      :includeUnratedSongs => "",
      :unratedSongsRating => ""
    ))
  end

  it "renders the edit playlist form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => playlists_path(@playlist), :method => "post" do
      assert_select "input#playlist_name", :name => "playlist[name]"
      assert_select "input#playlist_user", :name => "playlist[user]"
      assert_select "input#playlist_amountOfSongs", :name => "playlist[amountOfSongs]"
      assert_select "input#playlist_includeUnratedSongs", :name => "playlist[includeUnratedSongs]"
      assert_select "input#playlist_unratedSongsRating", :name => "playlist[unratedSongsRating]"
    end
  end
end
