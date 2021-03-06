class PiePiper < Sinatra::Base
  post '/orders/edit/:order_id' do
    @error = check_input(params[:item],params[:quantity])
    if(@error == false)
      order = Order.find(params[:order_id])
      order.edit_order(params[:item], params[:quantity], params[:reward])
      order.order_state_id = params[:order_state]
      order.save
      # if setting state to ready
      if(params[:order_state] == "2")
          user = order.get_tweet.user.screen_name
          tweet = order.get_tweet.id
          name = User.find(order.user_id).fullname
          text = "your order is ready."
          text += " Time: "+params[:time] + "."
          total_price = display_currency(order.total_price)
          # send tweet saying order is ready
          $client.update("@"+user+" "+name + ", " + text + " Your order costs: " + total_price, in_reply_to_status_id: tweet)
      end
      redirect '/orders'
    else
      @title = "Edit order"
      erb :'/orders/edit'
    end
  end

  get '/orders/edit' do
    authenticate!
    redirect '/orders'
  end

  get '/orders/edit/:order_id' do
    authenticate!
    @js = ['/scripts/forms.js', '/scripts/bootstrap-datetimepicker.min.js']
    @order_id = params['order_id']
    @order = Order.find(@order_id) if(Order.exists?(@order_id))
    if(!@order)
      @error = $errors[:order_not_exist]
    else
      # get 280 character tweet
      @tweet = @order.get_tweet if @order
      if @tweet.truncated? && @tweet.attrs[:extended_tweet]
        @tweet_text = @tweet.attrs[:extended_tweet][:full_text]
      else
        @tweet_text = @tweet.attrs[:text] || @tweet.attrs[:full_text]
      end
      @user = @order.user if @order
      @user_campaigns = @user.user_campaigns
    end
    @title = "Edit order"
    erb :'/orders/edit'
  end
end
