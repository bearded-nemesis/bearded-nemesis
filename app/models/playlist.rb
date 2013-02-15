class Playlist < ActiveRecord::Base
  belongs_to :user
  before_save :ensure_owner_is_player
  before_create :ensure_owner_is_player
  before_validation :ensure_unique_players

  attr_accessible :name, :user, :rock_party, :players

  def ensure_owner_is_player
    players << PlaylistUser.new(user: user, playlist: self) unless players.any? {|item| item.user == user}
  end

  def ensure_unique_players
    players.map {|item| item.user}.uniq.length == players.length
  end

  has_many :players, class_name: "PlaylistUser", :uniq => true
  has_many :songs, class_name: "PlaylistSong"
  belongs_to :rock_party

  def add_generated_songs(generator, player_instruments, options = {})
    remove_unrated = options[:remove_unrated]
    default_rating = options[:default_rating] || 3

    songs_to_use = block_given? ? user.songs.select {|song| yield song } : user.songs

    existing_songs = songs.map {|song| song.song.id}
    songs_ids = songs_to_use.map {|song| song.id}.uniq - existing_songs
    ratings = {}

    songs_to_remove = []

    player_users.each do |player|
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
        data["#{instrument}_rocker".to_sym] = player_users.find {|item| item.id == player}
      end

      songs.create data
    end
  end

  def player_users
    players.map {|item| item.user }
  end
end
