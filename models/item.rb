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

  def self.write_to_pdf
    table_data = []
    table_data << ["Name", "Price", "Type"]
    Item.all.each do |item|
      table_data << [item.name, item.price, item.item_type.name]
    end
    Prawn::Document.generate "price_list.pdf" do |pdf|
      table = pdf.make_table(table_data)
       table.row(0).font_style = :bold
      table.draw
    end
  end
end
