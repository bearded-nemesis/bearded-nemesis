class Rating < ActiveRecord::Base
  attr_accessible :bass, :drums, :guitar, :keyboard, :overall, :vocal, :user, :song

  belongs_to :song
  belongs_to :user
end
