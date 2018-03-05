def check_input(items, quantities)
  items.each do |item|
    if(item.empty?)
      return "Can't have an empty item"
      break
    elsif(!isitem(item))
      return "Item '#{item}' doesn't exist"
      break
    end
  end
  quantities.each do |quantity|
    quantity = quantity.to_i
    if(quantity <= 0)
      return "Invalid quantity"
      break
    end
  end
  return false
end

def isorder(tweet_id: nil, order_id: nil)
  if(order_id == nil)
    return !get_order(tweet: tweet_id).id.nil?
  else 
    return !get_order(id: order_id).tweet.nil?
  end
end

def get_order_item(id)
  return OrderItem.new(id)
end

def get_order_items(order_id)
  order_items = []
  query = $db.prepare "SELECT ID FROM OrderItems WHERE `Order` = CAST(? as INTEGER)"
  query.bind_params(order_id)
  results = query.execute
  while (row = results.next) do
      order_items.push(get_order_item(row.join))
  end
  return order_items;
  query.close if query
end

def get_order(id: nil, tweet: nil)
  return Order.new(id, tweet)
end

def get_orders(user: nil, state: nil)
  orders = []
  if(user == nil && state == nil)
    query = $db.prepare "SELECT ID FROM Orders"
  elsif(user == nil)
    query = $db.prepare "SELECT ID FROM Orders WHERE State = CAST(? as INTEGER)"
    query.bind_params(state.id)
  else
    query = $db.prepare "SELECT ID FROM Orders WHERE User = CAST(? as INTEGER)"
    query.bind_params(user.id)
  end
  results = query.execute
  while (row = results.next) do
      orders.push(get_order(id: row.join))
  end
  return orders;
  query.close if query
end

def new_order(items, quantities, tweet_id)
  user_id = get_user(twitter_id: $client.status(tweet_id).user.id).id
  # Creates new order
  $db.execute("INSERT INTO Orders (User, Tweet, State) VALUES (?, CAST(? as TEXT), 1)", [user_id, tweet_id])
  new_order_id = $db.last_insert_row_id()
  items.each_with_index do |item,i|
    $db.execute("INSERT INTO OrderItems (`Order`, Item, Quantity) VALUES (?, ?, ?)", [new_order_id, get_item(name: item).id, quantities[i]])
  end
  ordertweet = get_order(id: new_order_id).tweet
  $client.update('@'+ordertweet.user.screen_name+' We\'ve received your order', :in_reply_to_status_id => ordertweet.id)
end

def edit_order(items, quantities, order_id)
  $db.execute("DELETE FROM OrderItems WHERE `Order` = CAST(? as INTEGER)",[order_id])
  items.each_with_index do |item,i|
    $db.execute("INSERT INTO OrderItems (`Order`, Item, Quantity) VALUES (?, ?, ?)", [order_id.to_i, get_item(name: item).id, quantities[i].to_i])
  end
end

def get_order_state(id: nil, name: nil)
  return OrderState.new(id,name)
end

def get_order_states
  states = []
  query = $db.prepare "SELECT ID FROM OrderStates"
  results = query.execute
  while (row = results.next) do
      states.push(get_order_state(id: row.join))
  end
  return states;
  query.close if query
end

def delete_order(id)
  get_order(id: id).delete()
end

def total_order_price(order_items)
  total = 0
  order_items.each do |order_item|
    price = order_item.item.price
    quantity = order_item.quantity
    total += (price*quantity)
  end
  return total
end