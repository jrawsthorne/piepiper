require_relative 'new'
require_relative 'edit'
require_relative 'delete'

class PiePiper < Sinatra::Base
  get '/orders' do
    order_handler!
    @js = ['/scripts/orders.js']
    @title = "Orders"
    erb :'orders/orders'
  end
  
  get '/orders/completed' do
    order_handler!
    @title = "Orders"
    @orders = Order.where('order_state_id = 3')
    erb :'orders/completed'
  end
end
