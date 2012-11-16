class Song < ActiveRecord::Base
  SOURCES = ["Rock Band 1",
             "Rock Band 2",
             "Rock Band 3",
             "Downloadable Content",
             "Rock Band Network",
             "The Beatles: Rock Band",
             "Lego Rock Band",
             "Green Day: Rock Band",
             "Rock Band Track Pack Country 2",
             "Rock Band Track Pack AC/DC Live"]

  before_save :convert_blank_ratings_to_nil

  validates :artist, :name, :genre, presence: true
  validates :bass_difficulty,
            :drums_difficulty,
            :guitar_difficulty,
            :keyboard_difficulty,
            :vocals_difficulty,
            :song_difficulty,
            :pro_keyboard_difficulty,
            :pro_drums_difficulty,
            :pro_guitar_difficulty,
            :pro_bass_difficulty,
            :pro_vocals_difficulty,
            :numericality => { only_integer: true,
                               greater_than_or_equal_to: 0,
                               less_than_or_equal_to: 6 }

  attr_accessible :bass_difficulty, :drums_difficulty, :genre,
                  :guitar_difficulty, :keyboard_difficulty, :name, :artist,
                  :song_difficulty, :vocals_difficulty,
                  :pro_keyboard_difficulty, :pro_drums_difficulty,
                  :pro_guitar_difficulty, :pro_bass_difficulty,
                  :pro_vocals_difficulty, :year, :release_date, :source

  has_many :ratings
  has_and_belongs_to_many :users

  def convert_blank_ratings_to_nil
    bass_difficulty
  end
end
