def get_items_with_prices
  prices = {}
  Item.all.each do |item|
    name = item.name
    prices[name] = item.price
  end
  return prices
end