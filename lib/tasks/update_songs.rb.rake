task :update_songs => :environment do
  require 'json'
  require 'nokogiri'
  require 'open-uri'

  existing_songs = Song.select(:shortname).map {|item| item.shortname}
  songs = JSON.parse(open('http://services.rockband.com/leaderboard_data/rb3/xbox/song_list.json').read)

  songs.each do |item|
    shortname = item["shortname"]
    next if existing_songs.any? {|existing| existing == shortname}

    url = 'http://www.rockband.com/songs/' + shortname
    puts "Getting #{url}..."
    doc = Nokogiri::HTML(open(url))

    song = Song.new
    song.shortname = shortname
    song.name = doc.css('.song-detail')[0].children[0].content.strip
    song.artist = doc.css('.song-detail span a')[0].content.strip
    song.release_date = doc.css(".secondary li")[2].children[1].content.strip
    song.year = doc.css('.song-detail li.alt')[1].children[1].content.strip
    song.genre = doc.css('.song-detail li.alt')[2].children[1].content.strip
    song.source = doc.css('.song-details .rbn')[0].children[2].content.strip

    song.song_difficulty = difficulty doc.css('.band-difficulty li>span')[0].get_attribute('class')

    %W[guitar bass drums keys vocals].each do |instrument|
      song.send("#{instrument_field instrument}_difficulty=",
                difficulty(doc.css(".basic-difficulties li.#{instrument}>span")[0].get_attribute('class')))
      song.send("pro_#{instrument_field instrument}_difficulty=",
                difficulty(doc.css(".pro-difficulties li.#{instrument}>span")[0].get_attribute('class')))
    end

    puts "Adding #{song.name}..."
    song.save!
  end
end

def instrument_field(instrument)
  return "keyboard" if instrument == "keys"
  instrument
end

def difficulty(diff)
  return 6 if diff == "devils"
  return 5 if diff == "fivedots"
  return 4 if diff == "fourdots"
  return 3 if diff == "threedots"
  return 2 if diff == "twodots"
  return 1 if diff == "onedot"
  return 1 if diff == "zerodots"
  nil
end