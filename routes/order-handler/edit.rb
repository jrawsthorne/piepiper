post '/edit-order/:order_id' do
  @error = check_input(params[:item],params[:quantity])
  if(@error == false)
    edit_order(params[:item], params[:quantity], params[:order_id])
    redirect '/orders'
  else
    @title = "Edit order"
    erb :'edit-order'
  end
end

get '/edit-order' do
  authenticate!
  redirect '/orders'
end

get '/edit-order/:order_id' do
  authenticate!
  @js = 'forms.js'
  @title = "Edit order"
  erb :'edit-order'
end