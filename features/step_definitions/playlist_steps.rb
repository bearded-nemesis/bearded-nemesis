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

When /^I enter the following songs$/ do |songs|
  songs.hashes.each do |item|
    page.execute_script %Q{ $('input[data-autocomplete]').trigger("focus") }
    fill_in "add-song", with:item["Name"]
    page.execute_script %Q{ $('input[data-autocomplete]').trigger("keydown") }
    sleep 1
    page.execute_script %Q{ $('.ui-menu-item a:contains("#{item["Name"]}")').trigger("mouseenter").trigger("click"); }
  end
end

When /^I am on the detail page for playlist "(.*?)"$/ do |playlist_name|
  playlist = Playlist.find_by_name playlist_name
  begin
    visit playlist_path(playlist)
  rescue ActionController::RoutingError

  end
end