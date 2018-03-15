require_relative 'new'
require_relative 'edit'
require_relative 'delete'

get '/orders' do
  authenticate!
  @title = "Orders"
  erb :orders
end