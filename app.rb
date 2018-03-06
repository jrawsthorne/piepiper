require 'sinatra'
require 'sinatra/flash'
require 'active_record'
require 'twitter'
require 'json'
require 'omniauth-twitter'
require_relative 'models/init'
require_relative 'helpers/init'
require_relative 'routes/init'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'piepiper.db'
)

enable :sessions
set :session_secret, 'to%LRLr#GdYWf9Mh@#Yf*E89#Wzp#x6tXSgQG#@b7WJ6Oet66va@fgxxWw11gtinVUx92Bvl3wNBG7nQhlfw1MYXRAmhRaGU7c@x'

before do
  config = {
      :consumer_key => 'vqJ9GQDOns00WAQx7oDoBJqFX',
      :consumer_secret => 'HmlsBdLGWcZXcFCiidsq74AlLr2XWJnKaO09QPxMWN24ZdpxjK',
      :access_token => '965615031185485824-xCVnWm6q628bwhbLcFjhAsGCpPojDKT',
      :access_token_secret => 'ilEkrfVAahr8odgafGkodNkRl045MbbSgeoicL4x80EB8'
  }
  $client = Twitter::REST::Client.new(config)
end

use OmniAuth::Builder do
  provider :twitter, 'vqJ9GQDOns00WAQx7oDoBJqFX', 'HmlsBdLGWcZXcFCiidsq74AlLr2XWJnKaO09QPxMWN24ZdpxjK'
end

get '/account' do
  authenticate!
  @title = "Account Settings"
  erb :account
end

get '/login_twitter' do
  redirect to("/auth/twitter")
end

get '/auth/twitter/callback' do
  auth = request.env["omniauth.auth"]
  if(User.exists?(twitter_id: auth.uid))
    user = User.find_by(twitter_id: auth.uid)
    auth ? session[:user_id] = user.id : halt(401,'Not Authorized')
    redirect '/account'
  else
    flash[:twitter_id] = auth.uid
    redirect '/signup'
  end
end

=begin
post '/signup' do
  new_user(
    params[:username],
    params[:firstname],
    params[:lastname],
    params[:password],
    params[:twitter_handle],
    params[:dietaryrequirements],
    params[:house_number],
    params[:address_line_1],
    params[:address_line_2],
    params[:city_region],
    params[:postcode]
          )
end
=end

def new_user(username, firstname, lastname, password,
            twitter_id, special_conditions,
            house_number, address_line_1, address_line_2,
            city_region, postcode)
  user = User.new do |u|
    u.username = username
    u.firstname = firstname
    u.lastname = lastname
    u.password = "password"
    u.twitter_id = twitter_id.to_s
    special_conditions.each do |condition|
      
    end
    u.house_number = house_number
    u.address_line_1 = address_line_1
    u.address_line_2 = address_line_2
    u.city_region = city_region
    u.postcode = postcode
    u.account_type_id = 1
  end
  user.save
  session[:user_id] = user.id
  puts session[:user_id]
end
