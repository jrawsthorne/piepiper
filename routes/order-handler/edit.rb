class PiePiper < Sinatra::Base
  post '/edit-order/:order_id' do
    @error = check_input(params[:item],params[:quantity])
    if(@error == false)
      Order.find(params[:order_id]).edit_order(params[:item], params[:quantity])
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
    @js = ['/scripts/forms.js']
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
