#Checks the validity of passed items and their quantities
def check_input(items, quantities)

  #Checks if the item exists and isnt empty, returns an error message if not
  items.each do |item|
    if(item.empty?)
      return "Can't have an empty item"
      break
    elsif(!Item.exists?(name: item))
      return "Item '#{item}' doesn't exist"
      break
    end
  end

  #Fails if two lists don't have the same length
  if(items.length != quantities.length)
    return "Mismatch"
  end

  #Fails if any quantity is less than 1
  quantities.each do |quantity|
    quantity = quantity.to_i
    if(quantity <= 0)
      return "Invalid quantity"
      break
    end
  end
  return false
end

#Used to create a new order in the Orders table
def new_order(items, quantities, tweet_id, campaign_id)

  #Creates the new order in the table, with the passed parameters
  order = Order.new do |u|
    u.user_id = User.where(twitter_id: get_user_from_tweet(tweet_id)).pluck(:id).join
    u.tweet_id = tweet_id
    u.order_state_id = 1
    u.location_id = User.where(twitter_id: get_user_from_tweet(tweet_id)).pluck(:location_id).join
    if(campaign_id)
      u.campaign_id = campaign_id
    end
  end
  order.save

  #Creates each order_item in the Order linking table
  items.each_with_index do |item,i|
    order_item = OrderItem.new do |u|
      u.order_id = order.id
      u.item_id = Item.find_by(name: item).id
      u.quantity = quantities[i].to_i
    end
    order_item.save
  end
end
