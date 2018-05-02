require_relative 'new'
require_relative 'edit'
require_relative 'delete'

class PiePiper < Sinatra::Base
  get '/orders' do
    order_handler!
    @js = ['/scripts/orders.js']
    if(!params[:location] || !Location.exists?(name: params[:location]))
      if(!Location.exists?(session[:location_id]))
          # set location to first in db if not in session or url
          @location = Location.first
      else
          # set location to session location id
          @location = Location.find(session[:location_id])
      end
    else
      # set location to url location id
      @location = Location.find_by(name: params[:location])
    end
    @title = @location.name+" Orders"
    @locations = Location.all
    @orders = Order.where(location_id: @location.id, order_state_id: [1,2])
    @completed_orders = Order.where(location_id: @location.id, order_state_id: [3])
    begin
      mentions = $client.mentions_timeline(tweet_mode: "extended")
      @tweets = mentions.select do |tweet|
        # select all tweets that aren't replies, aren't already orders, aren't hidden, have hastag #order, are from users with specified location
        tweet.in_reply_to_status_id.nil? and !HiddenTweet.find_by(tweet_id: tweet.id) and !Order.exists?(tweet_id: tweet.id) and !tweet.hashtags.empty? and tweet.hashtags[0].text == "order" and User.exists?(twitter_id: tweet.user.id) and User.find_by(twitter_id: tweet.user.id).location_id == @location.id
      end
    rescue Twitter::Error
      @tweets = nil
    end

    erb :'orders/orders'
  end

  get '/orders/completed' do
    order_handler!
    if(!params[:location] || !Location.exists?(name: params[:location]))
      if(!Location.exists?(session[:location_id]))
          # set location to first in db if not in session or url
          @location = Location.first
      else
          # set location to session location id
          @location = Location.find(session[:location_id])
      end
    else
      @location = Location.find_by(name: params[:location])
    end
    @title = "Completed "+@location.name+" Orders"
    @locations = Location.all
    @orders = Order.where(location_id: @location.id, order_state_id: 3)
    erb :'orders/completed'
  end

  get '/orders/hide/:tweet_id' do
    order_handler!
    if(istweet(params[:tweet_id]))
      hidden = HiddenTweet.new do |h|
        h.tweet_id = params[:tweet_id]
      end
      hidden.save
    end
    redirect('/orders')
  end

  get '/orders/hide' do
    order_handler!
    redirect('/orders')
  end

end
