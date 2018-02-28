require 'sinatra'
require 'twitter'
require 'json'

before do
  config = {
      :consumer_key => 'vqJ9GQDOns00WAQx7oDoBJqFX',
      :consumer_secret => 'HmlsBdLGWcZXcFCiidsq74AlLr2XWJnKaO09QPxMWN24ZdpxjK',
      :access_token => '965615031185485824-xCVnWm6q628bwhbLcFjhAsGCpPojDKT',
      :access_token_secret => 'ilEkrfVAahr8odgafGkodNkRl045MbbSgeoicL4x80EB8'
  }
  @client = Twitter::REST::Client.new(config)
end

def current_class?(test_path)
    request.path == test_path ? 'active' : ''
end

get '/' do
  @title = "Menu"
  erb :index
end

get '/about' do
  @title = "About Us"
  erb :about
end

get '/login' do
  @title = "Login"
  erb :login
end

get '/orders' do
  @title = "Orders"
  erb :orders
end

post '/new-order' do
  # Submit stuff to the database here
  # returns some stuff for now - will be a separate get url when the database works
  content_type :json
  { :username => @client.status(params[:tweet_id]).user.screen_name, :items => params[:items] }.to_json
end

get '/new-order' do
  redirect '/orders'
end
