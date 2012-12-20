class RockParty < ActiveRecord::Base
  attr_accessible :eventDate, :user, :location, :name
  
  belongs_to :user
  
  has_many :users
end
