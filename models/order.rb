class OrderItem
  attr_accessor :id, :order_id, :item, :quantity
  def initialize(id)
    @id = id
    @order_id = $db.get_first_value("SELECT `Order` FROM OrderItems WHERE ID = CAST(? as INTEGER)",[@id])
    @item = get_item(id: $db.get_first_value("SELECT Item FROM OrderItems WHERE ID = CAST(? as INTEGER)",[@id]))
    @quantity = $db.get_first_value("SELECT Quantity FROM OrderItems WHERE ID = CAST(? as INTEGER)",[@id])
  end
end

class Order
  attr_accessor :id, :tweet, :user, :state, :items
  def initialize(id = nil, tweet = nil)
    if (id == nil)
      @id = $db.get_first_value("SELECT ID FROM Orders WHERE Tweet = CAST(? as TEXT)",[tweet])
      @tweet = tweet
    else
      begin
        @tweet = $client.status($db.get_first_value("SELECT Tweet FROM Orders WHERE ID = CAST(? as INTEGER)",[id]))
      rescue Twitter::Error
      end
      @id = id
    end
    @user = get_user(id: $db.get_first_value("SELECT User FROM Orders WHERE ID = CAST(? as INTEGER)",[@id]))
    @state = get_order_state(id: $db.get_first_value("SELECT State FROM Orders WHERE ID = CAST(? as INTEGER)",[@id]))
    @items = get_order_items(@id)
  end
  def delete()
    $db.execute("DELETE FROM OrderItems WHERE `Order` = CAST(? as INTEGER)",[@id])
    $db.execute("DELETE FROM Orders WHERE ID = CAST(? as INTEGER)",[@id])
  end
end

class OrderState
  attr_accessor :id, :name
  def initialize(id = nil, name = nil)
    if (id == nil)
      @id = $db.get_first_value("SELECT ID FROM OrderStates WHERE Name = CAST(? as TEXT)",[name])
      @name = name
    else
      @name = $db.get_first_value("SELECT Name FROM OrderStates WHERE ID = CAST(? as INTEGER)",[id])
      @id = id
    end
  end
end