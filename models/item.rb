require 'prawn'

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
  


  def write_to_pdf
    table_data = []
    Item.all.each do |item|
      table_data << [item.name, item.price, item.item_type.name]
    end
    Prawn::Document.new do |pdf|
      table = pdf.make_table(table_data)
      table.draw
      pdf.render_file("price_list.pdf")
    end
  end
end
