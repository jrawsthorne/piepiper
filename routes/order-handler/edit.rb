class PiePiper < Sinatra::Base
  post '/edit-order/:order_id' do
    @error = check_input(params[:item],params[:quantity])
    if(@error == false)
      order = Order.find(params[:order_id])
      order.edit_order(params[:item], params[:quantity])
      order.order_state_id = params[:order_state]
      order.save
      if(params[:order_state] == "2")
          user = order.get_tweet.user.screen_name
          tweet = order.get_tweet.id
          name = User.find(order.user_id).fullname
          text = "your order is ready."
          text += " Time: "+params[:time]
          $client.update("@"+user+" "+name + ", " + text, in_reply_to_status_id: tweet)
      end
      redirect '/orders'
    else
      @title = "Edit order"
      erb :'/orders/edit-order'
    end
  end

  get '/edit-order' do
    authenticate!
    redirect '/orders'
  end

  get '/edit-order/:order_id' do
    authenticate!
    @js = ['/scripts/forms.js', '/scripts/bootstrap-datetimepicker.min.js']
    @order_id = params['order_id']
    @order = Order.find(@order_id) if(Order.exists?(@order_id))
    @tweet = @order.get_tweet if @order
    if @tweet.truncated? && @tweet.attrs[:extended_tweet]
      @tweet_text = @tweet.attrs[:extended_tweet][:full_text]
    else
      @tweet_text = @tweet.attrs[:text] || @tweet.attrs[:full_text]
    end
    @user = @order.user if @order
    @title = "Edit order"
    erb :'/orders/edit-order'
  end
end
