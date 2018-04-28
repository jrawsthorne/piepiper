require_relative 'new'
require_relative 'edit'
require_relative 'delete'

class PiePiper < Sinatra::Base
  get '/orders' do
    order_handler!
    @js = ['/scripts/orders.js', '/scripts/locationChanger.js']
    @title = "Orders"
    if(!params[:location] || !Location.exists?(name: params[:location]))
      @location = Location.find(session[:location_id])
    else
      @location = Location.find_by(name: params[:location])
    end
    @locations = Location.all
    @orders = Order.where(location_id: @location.id)
    erb :'orders/orders'
  end
  
  get '/orders/completed' do
    order_handler!
    @title = "Orders"
    @orders = Order.where('order_state_id = 3')
    erb :'orders/completed'
  end
end
