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

Given /^(\d+) random songs$/ do |song_count|
  songs = []

  (0...song_count.to_i).map do
    songs << { "name" => (0...16).map{65.+(rand(26)).chr}.join }
  end

  create_songs songs
end

Given /^I own all the songs$/ do
  Song.all.each do |song|
    song.users << @current_user
    song.save!
  end
end

Given /^all the songs have random ratings$/ do
  users = User.all

  Song.all.each do |song|
    users.each do |user|
      rating = Rating.new user: user, song: song
      rating.bass = Random.rand(6)
      rating.drums = Random.rand(6)
      rating.guitar = Random.rand(6)
      rating.keyboard = Random.rand(6)
      rating.vocals = Random.rand(6)
      rating.overall = Random.rand(6)
      rating.pro_keyboard = Random.rand(6)
      rating.pro_drums = Random.rand(6)
      rating.pro_guitar = Random.rand(6)
      rating.pro_bass = Random.rand(6)
      rating.pro_vocals = Random.rand(6)
      rating.save!
    end
  end
end

Given /^there are (\d+) songs$/ do |count|
  FactoryGirl.create_list :song, count.to_i
end

When /^I own the following songs$/ do |table|
  table.hashes.each do |song|
    song = Song.find_by_name song[:name]
    song.users << @current_user
    song.save!
  end
end

When /^I have rated the following songs$/ do |table|
  table.hashes.each do |item|
    song = Song.find_by_name item[:name]
    rating = Rating.where(user_id: @current_user, song_id: song).first
    rating ||= Rating.new user: @current_user, song: song
    rating[item[:instrument].to_sym] = item[:rating].to_i
    rating.save
  end
end

Then /^my rating for "(.*?)" on "(.*?)" should be (\d+)$/ do |instrument, song, value|
  song = Song.find_by_name song
  rating = Rating.where(song_id: song, user_id: @current_user).first

  puts instrument
  p rating

  rating[instrument.to_sym].should eq(value.to_i)
end

When /^I should not have a rating for "(.*?)" on "(.*?)"$/ do |instrument, song_name|
  song = Song.find_by_name song_name
  rating = Rating.where(song_id: song, user_id: @current_user).first
  rating.should eq(nil) or rating[instrument.to_sym].should eq(value.to_i)
end


private

def get_mark_song_as_owned_span(song_name)
  song = Song.find_by_name song_name
  path = own_song_path song
  find :css, "span[data-url='#{path}']"
end

def create_songs(songs)
  songs.each do |elem|
    item = elem.clone

    item["artist"] ||= "Dummy Artist"
    item["genre"] ||= "Rock"
    item["shortname"] ||= item["name"]

    Song.create! item
  end
end