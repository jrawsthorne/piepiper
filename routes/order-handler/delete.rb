get '/delete-order/:order_id' do
  authenticate!
  order_id = params[:order_id]
  if(isorder(order_id: order_id))
    delete_order(order_id)
  end
  redirect '/orders'
end

get '/delete-order' do
  authenticate!
  redirect '/orders'
end