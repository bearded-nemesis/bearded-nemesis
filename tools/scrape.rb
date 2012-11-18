require 'nokogiri'
require 'open-uri'
require 'json'
require 'yaml'

song_file = "songs.yaml"
instruments = %W[guitar bass drums keys vocals]

songs = YAML::load(File.open(song_file)) if File.exist? song_file

unless songs
  data = ""
  open('http://services.rockband.com/leaderboard_data/rb3/xbox/song_list.json') { |io| data = io.read }
  songs = JSON.parse data
end

songs.find_all {|s| s[:difficulties].nil?}.each do |song|
  puts "Loading #{song['fullname']}...}"
  song[:url] = "http://www.rockband.com/songs/#{song['shortname']}"

  # Get a Nokogiri::HTML::Document for the page we’re interested in...

  doc = Nokogiri::HTML(open(song[:url]))

  # Get the song name

  #song_name = doc.css('h2.song-detail').children[0].content.strip

  # Get the artist title and url
  artist_elem = doc.css('h2.song-detail span a')[0]
  song[:artist_name] = artist_elem.children[0].content.strip
  song[:artist_url] = artist_elem[:href].strip

  # Get the name of the album
  song[:album_name] = doc.css('.album').text.strip
  song[:year] = doc.css('.song-details .alt')[1].children[1].text.strip
  song[:genre] = doc.css('.song-details .alt')[2].children[1].text.strip
  song[:source] = doc.css('.song-details > .rbn').children[2].text.strip
  song[:release_date] = doc.css('.secondary .alt').children[1].text.strip

  # Get difficulties
  song[:difficulties] = {}
  song[:difficulties]["song"] = doc.css('.difficulties .band > span')[0][:class]

  instruments.each do |instrument|
    song[:difficulties][instrument] = doc.css(".difficulties .basic-difficulties .#{instrument.to_s} > span")[0][:class]
  end

  instruments.each do |instrument|
    song[:difficulties]["pro_#{instrument}"] = doc.css(".difficulties .pro-difficulties .#{instrument.to_s} > span")[0][:class]
  end

  File.open(song_file, "w") do |f|
    f.write(songs.to_yaml)
  end
end


