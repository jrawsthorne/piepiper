class PiePiper < Sinatra::Base
  get '/delete-order/:order_id' do
    order_handler!
    order_id = params[:order_id]
    if(Order.exists?(order_id))
      order = Order.find(order_id)
      order.order_items.each do |order_item|
        order_item.destroy
      end
      order.destroy
      flash[:delete_order] = order_id
    end
    redirect '/orders'
  end

  get '/delete-order' do
    order_handler!
    redirect '/orders'
  end
end