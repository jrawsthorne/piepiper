class PiePiper < Sinatra::Base
  post '/new-order/:tweet_id' do
    order_handler!
    @error = check_input(params[:item],params[:quantity])
    if(@error == false)
      new_order(params[:item], params[:quantity], params[:tweet_id])
      flash[:new_order] = Order.where(tweet_id: params[:tweet_id]).pluck(:id).join
      redirect '/orders'
    else
      @title = "New order"
      erb :'/orders/new-order'
    end
  end

  get '/new-order' do
    order_handler!
    redirect '/orders'
  end

  get '/new-order/:tweet_id' do
    order_handler!
    @js = ['/scripts/forms.js']
    @title = "New order"
    erb :'/orders/new-order'
  end

  get '/api/get-items' do
    if(authenticated?)
      prices = get_items_with_prices
      content_type :json
      return prices.to_json
    else
      return {}
    end
  end

  post '/send-tweet' do
    payload = params
    payload = JSON.parse(request.body.read).symbolize_keys unless params[:path]
    if(authenticated?)
      tweet = $client.update("@"+payload[:user]+" "+payload[:tweet], in_reply_to_status_id: payload[:in_reply_to].to_i)
      if tweet.truncated? && tweet.attrs[:extended_tweet]
        tweet_text = tweet.attrs[:extended_tweet][:full_text]
      else
        tweet_text = tweet.attrs[:text] || tweet.attrs[:full_text]
      end
      return {
          created_at: tweet.created_at.asctime,
          tweet_text: tweet_text,
          user: {
            profile_image_url: tweet.user.profile_image_url.to_s,
            full_name: User.find_by(twitter_id: tweet.user.id).fullname
          }
      }.to_json
    else
      content_type :json
      status 400
      return {error: "Unauthorised"}.to_json
    end
  end

end
