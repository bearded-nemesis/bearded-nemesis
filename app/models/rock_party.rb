class RockParty < ActiveRecord::Base
  attr_accessible :eventDate, :eventHost, :location, :name
end
