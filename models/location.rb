class Location < ActiveRecord::Base
	has_many :item_locations
	has_many :items, through: :item_locations
end

class ItemLocation < ActiveRecord::Base
	belongs_to :location
	belongs_to :item
end