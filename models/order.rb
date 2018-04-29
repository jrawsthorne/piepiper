class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item
end

class OrderState < ActiveRecord::Base
end

class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :campaign
  belongs_to :order_state
  belongs_to :user
  belongs_to :location
  def get_tweet
    begin
	    return $client.status(tweet_id.to_i, tweet_mode: "extended")
	  rescue Twitter::Error
	    return nil
	  end
  end
  def total_price
    total = 0
    order_items.each do |order_item|
      total += order_item.item.price*order_item.quantity
    end
    if(campaign)
      discount = campaign.campaign_type.percentage_reduced
      if discount != 100 or nil
        total -= (total * discount / 100)
      end
    end
    return total
  end
  def edit_order(items, quantities)
    order_items.each do |order_item|
      order_item.destroy
    end
    items.each_with_index do |item,i|
      order_item = OrderItem.new do |u|
        u.order_id = id
        u.item_id = Item.find_by(name: item).id
        u.quantity = quantities[i].to_i
      end
      order_item.save
    end
  end
end