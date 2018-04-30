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

  #Gets tweet from order
  def get_tweet
    begin
	    return $client.status(tweet_id.to_i, tweet_mode: "extended")
	  rescue Twitter::Error
	    return nil
	  end
  end

  #Returns the total price of the order
  def total_price
    total = 0

    #Adds the prices of the orders up
    order_items.each do |order_item|
      total += order_item.item.price*order_item.quantity
    end

    #Applies any discounts
    if(campaign)
      discount = campaign.campaign_type.percentage_reduced
      if discount != 100
        total -= (total * discount / 100)
      elsif discount == 100
        i = []
        order_items.each do |order_item|
          i.push(order_item.item.price)
        end
        total -= i.min
      end
    end
    return total
  end

  #To edit an order in the table
  def edit_order(items, quantities, camp_id)

    #Deletes each order item from the table
    order_items.each do |order_item|
      order_item.destroy
    end

    #Saves the campaign ID of the order
    self.campaign_id = camp_id
    self.save

    #Saves the order_items for the current order
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
