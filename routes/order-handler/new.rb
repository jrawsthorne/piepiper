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
    @js = ['/scripts/forms.js', '/scripts/bootstrap-datetimepicker.min.js']
    @title = "New order"
    @tweet_id = params['tweet_id']
    if(!istweet(@tweet_id))
      @error = $errors[:tweet_not_exist]
    elsif(Order.exists?(tweet_id: @tweet_id))
      @error = $errors[:already_order]+' <a href="/edit-order/'+Order.where(tweet_id: @tweet_id).pluck(:id).join.to_s+'">View it here</a>'
    else
      @tweet = $client.status(@tweet_id, tweet_mode: "extended")
      @user = User.find_by(twitter_id: @tweet.user.id) if(User.exists?(twitter_id: @tweet.user.id))
      if(!@tweet.in_reply_to_status_id.nil? || @tweet.hashtags.empty? || @tweet.hashtags[0].text != "order")
        @error = "Sorry, that tweet isn't an order <a href='/orders'>Go to orders</a>"
      elsif(!@user)
        @error = $errors[:user_not_registered]
      end
      if @tweet.truncated? && @tweet.attrs[:extended_tweet]
        @tweet_text = @tweet.attrs[:extended_tweet][:full_text]
      else
        @tweet_text = @tweet.attrs[:text] || @tweet.attrs[:full_text]
      end
      mentions_after_tweet = $client.search("from:@"+@tweet.user.screen_name+" OR from:@piepiperchef to:@"+@tweet.user.screen_name, options = {since_id:@tweet.id})
      replies = mentions_after_tweet.reverse_each.select do |reply|
        !reply.in_reply_to_status_id.nil? && reply.in_reply_to_status_id === @tweet.id
      end
      rejected = mentions_after_tweet.reverse_each.reject do |reply|
        reply.in_reply_to_status_id === @tweet.id
      end
      rejected.each do |reply|
        reply_ids = replies.map{|reply| reply.id}
        replies_not_root = rejected.select do |reply|
          reply_ids.include?(reply.in_reply_to_status_id)
        end
        replies += replies_not_root
        rejected = rejected.reject do |reply|
          reply_ids.include?(reply.in_reply_to_status_id)
        end
      end
      @replies = replies.sort_by { |reply| reply.created_at.strftime("%s") }
      @user_campaigns = @user.user_campaigns
    end
    erb :'/orders/new-order'
  end

  get '/api/get-items' do
    if(authenticated? && params[:location])
      prices = get_items_with_prices(params[:location])
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
