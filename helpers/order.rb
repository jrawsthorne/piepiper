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
  if(items.length != quantities.length)
    return "Mismatch"
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

def new_order(items, quantities, tweet_id, campaign_id)
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
  items.each_with_index do |item,i|
    order_item = OrderItem.new do |u|
      u.order_id = order.id
      u.item_id = Item.find_by(name: item).id
      u.quantity = quantities[i].to_i
    end
    order_item.save
  end
end
