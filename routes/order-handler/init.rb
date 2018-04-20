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
end
