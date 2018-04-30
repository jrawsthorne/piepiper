class PiePiper < Sinatra::Base
  post '/orders/new/:tweet_id' do
    order_handler!
    @error = check_input(params[:item],params[:quantity])
    if(@error == false)
      new_order(params[:item], params[:quantity], params[:tweet_id], params[:reward])
      flash[:new_order] = Order.where(tweet_id: params[:tweet_id]).pluck(:id).join
      redirect '/orders'
    else
      @title = "New order"
      erb :'/orders/new'
    end
  end

  get '/orders/new' do
    order_handler!
    redirect '/orders'
  end

  get '/orders/new/:tweet_id' do
    order_handler!
    @js = ['/scripts/forms.js', '/scripts/bootstrap-datetimepicker.min.js']
    @title = "New order"
    @tweet_id = params['tweet_id']
    if(!istweet(@tweet_id))
      @error = $errors[:tweet_not_exist]
    elsif(Order.exists?(tweet_id: @tweet_id))
      # show error if tweet already associated with order
      @error = $errors[:already_order]+' <a href="/edit-order/'+Order.where(tweet_id: @tweet_id).pluck(:id).join.to_s+'">View it here</a>'
    else
      @tweet = $client.status(@tweet_id, tweet_mode: "extended")
      @user = User.find_by(twitter_id: @tweet.user.id) if(User.exists?(twitter_id: @tweet.user.id))
      # tweet must have #order, not be reply
      if(!@tweet.in_reply_to_status_id.nil? || @tweet.hashtags.empty? || @tweet.hashtags[0].text != "order")
        @error = "Sorry, that tweet isn't an order <a href='/orders'>Go to orders</a>"
      elsif(!@user)
        @error = $errors[:user_not_registered]
      end
      # get 280 character tweet
      if @tweet.truncated? && @tweet.attrs[:extended_tweet]
        @tweet_text = @tweet.attrs[:extended_tweet][:full_text]
      else
        @tweet_text = @tweet.attrs[:text] || @tweet.attrs[:full_text]
      end
      # get all tweets from user or piepiper to that user
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
      @campaign_types = CampaignType.all
    end
    erb :'/orders/new'
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

end
