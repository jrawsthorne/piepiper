require 'prawn'
require 'prawn/table'

class ItemType < ActiveRecord::Base
end

class SpecialCondition < ActiveRecord::Base
  has_many :users, through: :special_conditions_users
  has_many :special_conditions_users
end

class Item < ActiveRecord::Base
  belongs_to :special_condition
  belongs_to :item_type
  has_many :item_locations
  has_many :locations, through: :item_locations
  
  def edit_item(item_name, item_price, types, special_condition, locations)
    item_locations.each do |item_location|
      item_location.destroy
    end
    self.name = item_name
    self.price = item_price
    self.item_type_id = types
    self.special_condition_id = special_condition
    self.save
    locations.each do |locals|
  		item_locations = ItemLocation.new do |u|
  			u.item_id = id
  			u.location_id = locals
  		end
  		item_locations.save
  	end
  end
end
