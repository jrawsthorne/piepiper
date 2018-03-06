def check_input(items, quantities)
  items.each do |item|
    if(item.empty?)
      return "Can't have an empty item"
      break
    elsif(!Item.exists?(name: item))
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

def new_order(items, quantities, tweet_id)
  order = Order.new do |u|
    u.user_id = User.find_by(twitter_id: get_user_from_tweet(tweet_id)).id
    u.tweet = tweet_id.to_s
    u.order_state_id = 1
  end
  order.save
  items.each_with_index do |item,i|
    order_item = OrderItem.new do |u|
      u.order_id = order.id
      u.item_id = Item.find_by(name: item).id
      u.quantity = quantities[i].to_i
    end
    order_item.save
  end
end