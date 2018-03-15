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
    @js = 'forms.js'
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
    if(authenticated?)
      $client.update("@"+params[:user]+" "+params[:tweet], in_reply_to_status_id: params[:in_reply_to].to_i)
    end
  end
  
end