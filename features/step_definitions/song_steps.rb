Given /^the following songs$/ do |songs|
  songs.hashes.each do |item|
    item["artist"] ||= "Dummy Artist"
    item["genre"] ||= "Rock"
    item["shortname"] ||= item["name"]

    Song.create! item
  end
end

Given /^I am on the song list page$/ do
  visit songs_path
end

When /^I mark the song "(.*?)" as owned$/ do |song_name|
  get_mark_song_as_owned_span(song_name).click
end

Then /^song "(.*?)" should be owned by me$/ do |song_name|
  get_mark_song_as_owned_span(song_name).should have_content("Yes")
end

When /^I am on my song list page$/ do
  visit mine_songs_path
end

Given /^I own song "(.*?)"$/ do |song_name|
  song = Song.find_by_name song_name
  @current_user.songs << song
  @current_user.save!
end

When /^I mark the song "(.*?)" as not owned$/ do |song_name|
  get_mark_song_as_owned_span(song_name).click
end

Then /^song "(.*?)" should not be owned by me$/ do |song_name|
  get_mark_song_as_owned_span(song_name).should have_content("No")
end

When /^I remove song "(.*?)"$/ do |song_name|
  song = Song.find_by_name song_name
  path = song_path song
  link = find :css, "a[href='#{path}'][data-method='delete']"
  link.click
end

When /^I am on the edit page for song "(.*?)"$/ do |song_name|
  song = Song.find_by_name song_name
  begin
    visit edit_song_path(song)
  rescue ActionController::RoutingError

  end
end

When /^I am on the new song page$/ do
  begin
    visit new_song_path
  rescue ActionController::RoutingError

  end
end

private

def get_mark_song_as_owned_span(song_name)
  song = Song.find_by_name song_name
  path = own_song_path song
  find :css, "span[data-url='#{path}']"
end