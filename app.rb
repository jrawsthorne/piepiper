require 'sinatra'
require 'twitter'

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
<<<<<<< HEAD
  @title = "Menu"
=======
  @title = "Home"
>>>>>>> 150fbefc738dc5f2fce7f10dd6deb2972dac6a8b
  erb :index
end

get '/about' do
  @title = "About Us"
  erb :about
end

<<<<<<< HEAD
get '/login' do
  @title = "Login"
  erb :login
end

get '/orders' do
  @title = "Orders"
  erb :orders
end
=======
get '/contact' do
  @title = "Contact"
  erb :contact
end

get '/login' do
  @title = "Login"
  erb :login
end
>>>>>>> 150fbefc738dc5f2fce7f10dd6deb2972dac6a8b
