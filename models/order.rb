class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item
end

class OrderState < ActiveRecord::Base
end

class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :order_state
  belongs_to :user
  def get_tweet
    return $client.status(tweet_id.to_i, tweet_mode: "extended")
  end
  def total_price
    total = 0
    order_items.each do |order_item|
      total += order_item.item.price
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
<<<<<<< HEAD
end
=======
end
>>>>>>> a7ec877586362c19e5505aaf4e034f7409700bc6
