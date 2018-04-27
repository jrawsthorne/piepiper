
  def get_items_with_prices
    return Item.all.pluck(:name, :price).to_h
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
