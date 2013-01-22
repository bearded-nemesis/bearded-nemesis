class Playlist < ActiveRecord::Base
  belongs_to :user
  attr_accessible :amount_of_songs, :include_unrated_songs, :name, :unrated_songs_rating, :user

  has_and_belongs_to_many :users, :uniq => true do
    def <<(new_item)
      super new_item unless new_item == proxy_association.owner.user
    end
  end
  has_many :songs, class_name: "PlaylistSong"

  def players
    users + [user]
  end

  def add_generated_songs(generator, player_instruments, options = {})
    remove_unrated = options[:remove_unrated]
    default_rating = options[:default_rating] || 3

    existing_songs = songs.map {|song| song.song.id}
    songs_ids = user.songs.map {|song| song.id}.uniq - existing_songs
    ratings = {}

    songs_to_remove = []

    players.each do |player|
      player_ratings = player.ratings.includes :song
      instrument = player_instruments[player.id]

      songs_ids.each do |song|
        ratings[song] ||= {}
        rating = player_ratings.find {|item| item.song.id == song} || {}
        ratings[song][player.id] = rating[instrument] || default_rating
        songs_to_remove << song if rating[instrument].nil? and remove_unrated
      end
    end

    ratings.delete_if {|song| songs_to_remove.include? song}
    found_songs = generator.generate(ratings)
    return unless found_songs.respond_to? :each
    selected_songs = Song.find found_songs

    selected_songs.each do |song|
      data = { song: song }
      player_instruments.keys.each do |player|
        instrument = player_instruments[player].to_s.gsub "pro_", ""
        data["#{instrument}_rocker".to_sym] = players.find {|item| item.id == player}
      end

      songs.create data
    end
  end
end
