class Rating < ActiveRecord::Base
  validates :bass,
            :drums,
            :guitar,
            :keyboard,
            :vocals,
            :overall,
            :pro_keyboard,
            :pro_drums,
            :pro_guitar,
            :pro_bass,
            :pro_vocals,
            :numericality => { only_integer: true,
                               greater_than_or_equal_to: 0,
                               less_than_or_equal_to: 6}
  
  attr_accessible :bass, :drums, :guitar, :keyboard, :vocals,
                  :pro_bass, :pro_drums, :pro_guitar, :pro_keyboard, :pro_vocals,
                  :overall, :user, :song

  belongs_to :song
  belongs_to :user
end
