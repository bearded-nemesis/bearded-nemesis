Given /^the following playlists$/ do |playlists|
  playlists.hashes.each do |item|
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