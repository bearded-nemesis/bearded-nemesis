class Song < ActiveRecord::Base
  validates :artist, :name, :genre, presence: true
  validates :bass_difficulty,
            :drums_difficulty,
            :guitar_difficulty,
            :keyboard_difficulty,
            :vocals_difficulty,
            :song_difficulty,
            :numericality => { only_integer: true,
                               greater_than_or_equal_to: 0,
                               less_than_or_equal_to: 6}

  attr_accessible :bass_difficulty, :drums_difficulty, :genre, :guitar_difficulty, :keyboard_difficulty, :name, :artist, :song_difficulty, :vocals_difficulty
end
