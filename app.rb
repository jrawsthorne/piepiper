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