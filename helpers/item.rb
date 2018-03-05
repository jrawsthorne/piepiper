def isitem(item_name)
  return !get_item(name: item_name).id.nil?
end

def get_item(id: nil, name: nil)
  return Item.new(id,name)
end

def get_items(type: nil, special: nil)
  items = []
  if(type == nil && special == nil)
    query = $db.prepare "SELECT ID FROM Items"
  elsif(type == nil)
    query = $db.prepare "SELECT ID FROM Items WHERE Special = CAST(? as INTEGER)"
    query.bind_params(special.id)
  else
    query = $db.prepare "SELECT ID FROM Items WHERE Type = CAST(? as INTEGER)"
    query.bind_params(type.id)
  end
  results = query.execute
  while (row = results.next) do
      items.push(get_item(id: row.join))
  end
  return items;
  query.close if query
end

def get_items_with_prices
  prices = {}
  get_items.each do |item|
    name = item.name
    prices[name] = item.price
  end
  return prices
end

def get_item_names
  item_names = []
  get_items.each do |item| 
    item_names.push(item.name)
  end
  return item_names
end

def get_item_type(id: nil, name: nil)
  return ItemType.new(id,name)
end

def get_item_types
  types = []
  query = $db.prepare "SELECT ID FROM ItemTypes"
  results = query.execute
  while (row = results.next) do
      types.push(get_item_type(id: row.join))
  end
  return types;
  query.close if query
end

def get_item_special(id: nil, name: nil)
  return ItemSpecial.new(id,name)
end

def get_item_specials
  specials = []
  query = $db.prepare "SELECT ID FROM SpecialCondition"
  results = query.execute
  while (row = results.next) do
      specials.push(get_item_special(id: row.join))
  end
  return specials;
  query.close if query
end