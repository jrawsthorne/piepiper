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
    @orders = Order.where(location_id: @location.id, order_state_id: [1,2])
    @completed_orders = Order.where(location_id: @location.id, order_state_id: [3])
    mentions = $client.mentions_timeline(tweet_mode: "extended")
    @tweets = mentions.select do |tweet|
      tweet.in_reply_to_status_id.nil? and !Order.exists?(tweet_id: tweet.id) and !tweet.hashtags.empty? and tweet.hashtags[0].text == "order" and User.find_by(twitter_id: tweet.user.id).location_id == @location.id
    end
    erb :'orders/orders'
  end
  
  get '/orders/completed' do
    order_handler!
    @title = "Orders"
    @orders = Order.where(order_state_id: 3)
    erb :'orders/completed'
  end
end
