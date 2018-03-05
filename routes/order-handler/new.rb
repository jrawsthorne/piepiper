post '/new-order/:tweet_id' do
  authenticate!
  @error = check_input(params[:item],params[:quantity])
  if(@error == false)
    new_order(params[:item], params[:quantity], params[:tweet_id])
    redirect '/orders'
  else
    @title = "New order"
    erb :'new-order'
  end
end

get '/new-order' do
  authenticate!
  redirect '/orders'
end

get '/new-order/:tweet_id' do
  authenticate!
  @js = 'forms.js'
  @title = "New order"
  erb :'new-order'
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