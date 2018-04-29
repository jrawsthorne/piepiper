def get_items_with_prices(location_id)
  return Location.find(location_id).items.pluck(:name, :price).to_h
end

def new_item(
	name, price, types, special_condition_id, locations)
  
	item = Item.new do |u|
		u.name = name
		u.price = price
		u.item_type_id = types
		u.special_condition_id = special_condition_id
	end
	item.save

	locations.each do |locals|
		item_locations = ItemLocation.new do |u|
			u.item_id = item.id
			u.location_id = locals
		end
		item_locations.save
	end
end

def write_to_pdf(location_id)
  location = Location.find(location_id)
  table_data = []
  table_data << ["Name", "Price", "Type"]
  Location.find(location_id).items.each do |item|
    table_data << [item.name, display_currency(item.price), item.item_type.name]
  end
  Prawn::Document.generate location.name+"_price_list.pdf" do |pdf|
    table = pdf.make_table(table_data)
     table.row(0).font_style = :bold
    table.draw
  end
end