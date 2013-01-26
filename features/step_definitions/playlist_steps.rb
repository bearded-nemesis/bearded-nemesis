Given /^the following playlists$/ do |playlists|
  playlists.hashes.each do |item|
    item["user"] ||= @current_user

    Playlist.create! item
  end
end

Given /^I am on the playlist list page$/ do
  visit playlists_path
end

When /^I remove playlist "(.*?)"$/ do |playlist_name|
  playlist = Playlist.find_by_name playlist_name
  path = playlist_path playlist
  link = find :css, "a[href='#{path}'][data-method='delete']"
  link.click
end

When /^I am on the edit page for playlist "(.*?)"$/ do |playlist_name|
  playlist = Playlist.find_by_name playlist_name
  begin
    visit edit_playlist_path(playlist)
  rescue ActionController::RoutingError

  end
end

When /^I am on the detail[s]? page for playlist "(.*?)"$/ do |playlist_name|
  playlist = Playlist.find_by_name playlist_name
  begin
    visit playlist_path(playlist)
  rescue ActionController::RoutingError

  end
end

When /^I enter the song "(.*?)"$/ do |song_name|
  enter_song_in_autocomplete(song_name)
  page.execute_script %Q{ $('.ui-menu-item a:contains("#{song_name}")').trigger("mouseenter").trigger("click"); }
end

Then /^I should not see "(.*?)" in autocomplete$/ do |song_name|
  enter_song_in_autocomplete(song_name)
  page.evaluate_script(%Q{ $('.ui-menu-item a:visible:contains("#{song_name}")').length <= 0; }).should be_true
end

When /^I choose the following instruments for each player$/ do |table|
  table.hashes.each do |item|
    id = get_player item[:user]
    choose "instrument_#{id}_#{item[:instrument]}"
  end
end

Given /^playlist "([^"]*)" has the following songs$/ do |playlist_name, table|
  playlist = Playlist.find_by_name playlist_name
  table.hashes.each do |item|
    playlist.songs.create song: Song.find_by_name(item[:song])
  end
  playlist.save
end

When /^the following songs are in playlist "([^"]*)"$/ do |playlist_name, table|
  playlist = Playlist.find_by_name playlist_name

  table.hashes.each do |item|
    song = playlist.songs.build song: Song.find_by_name(item[:name])

    table.headers.drop(1).each do |element|
      key = ("#{item[element]}_rocker=").to_sym
      song.send key, get_player(element)
    end

    song.save!
  end
end

When /^I give a (\d+) star rating$/ do |rating|
  fill_in "Rating", with: rating
end

Then /^my rating for "(.*?)" on "(.*?)" should be (\d+)$/ do |instrument, song, value|
  song = Song.find_by_name song
  rating = Rating.where(song_id: song, user_id: @current_user).first
  rating[instrument.to_sym].should eq(value.to_i)
end

private

def enter_song_in_autocomplete(song_name)
  page.execute_script %Q{ $('input[data-autocomplete]').trigger("focus") }
  fill_in "add-song", with:song_name
  page.execute_script %Q{ $('input[data-autocomplete]').trigger("keydown") }
  sleep 1
end

def get_player(email)
  email =~ /^me$/i ? @current_user : User.find_by_email(email)
end