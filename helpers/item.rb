#Returns all items and prices available at the passed location
def get_items_with_prices(location_id)
  return Location.find(location_id).items.pluck(:name, :price).to_h
end

#Used to create a new item
def new_item(
	name, price, types, special_condition_id, locations)

  #New ActiveRecord object
  #Creates the new item in the Items table
	item = Item.new do |u|
		u.name = name
		u.price = price
		u.item_type_id = types
		u.special_condition_id = special_condition_id
	end
	item.save

  #Assigns the locations of the item
	locations.each do |locals|
		item_locations = ItemLocation.new do |u|
			u.item_id = item.id
			u.location_id = locals
		end
		item_locations.save
	end
end

#Generates a pdf document of the current menu
def write_to_pdf(location_id)
  location = Location.find(location_id)
  table_data = []

  #Arrays 'Table' headers
  table_data << ["Name", "Price", "Type"]

  #Writes the Name, Price and Location to the array
  Location.find(location_id).items.each do |item|
    table_data << [item.name, display_currency(item.price), item.item_type.name]
  end

  #Creates the actual pdf document from table_data
  Prawn::Document.generate location.name+"_price_list.pdf" do |pdf|
    table = pdf.make_table(table_data)
     table.row(0).font_style = :bold
    table.draw
  end
end
