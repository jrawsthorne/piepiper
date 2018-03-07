def get_items_with_prices
  return Item.all.pluck(:name, :price).to_h
end