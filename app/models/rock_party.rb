class RockParty < ActiveRecord::Base
  attr_accessible :eventDate, :user, :location, :name
  
  belongs_to :user

  has_and_belongs_to_many :users
end
