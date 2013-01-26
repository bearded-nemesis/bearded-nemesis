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
    id = item[:user] =~ /^me$/i ? @current_user.id : User.find_by_email(user_email)
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

When /^I change the select for "([^"]*)" to "([^"]*)"$/ do |song, instrument|
  select instrument, :from => "#{User.find(@current_user.id).email}[#{song}]"
end

Then /^I should see the "([^"]*)" option for "([^"]*)" selected$/ do |song, instrument|
  field_labeled("#{User.find(@current_user.id).email}[#{song}]").find(:xpath, ".//option[@selected = 'selected'][text() = '#{instrument}']").should be_present
end

private

def enter_song_in_autocomplete(song_name)
  page.execute_script %Q{ $('input[data-autocomplete]').trigger("focus") }
  fill_in "add-song", with:song_name
  page.execute_script %Q{ $('input[data-autocomplete]').trigger("keydown") }
  sleep 1
end