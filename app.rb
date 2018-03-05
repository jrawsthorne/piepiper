require 'sinatra'
require_relative 'models/init'
require_relative 'helpers/init'
require_relative 'routes/init'
require 'twitter'
require 'sqlite3'
require 'json'
require 'omniauth-twitter'

enable :sessions

before do
  config = {
      :consumer_key => 'vqJ9GQDOns00WAQx7oDoBJqFX',
      :consumer_secret => 'HmlsBdLGWcZXcFCiidsq74AlLr2XWJnKaO09QPxMWN24ZdpxjK',
      :access_token => '965615031185485824-xCVnWm6q628bwhbLcFjhAsGCpPojDKT',
      :access_token_secret => 'ilEkrfVAahr8odgafGkodNkRl045MbbSgeoicL4x80EB8'
  }
  $client = Twitter::REST::Client.new(config)
  $db = SQLite3::Database.new 'piepiper.db'
end

use OmniAuth::Builder do
  provider :twitter, 'vqJ9GQDOns00WAQx7oDoBJqFX', 'HmlsBdLGWcZXcFCiidsq74AlLr2XWJnKaO09QPxMWN24ZdpxjK'
end

helpers do
  def handle?
    session[:handle]
  end
end

get '/account' do
  @title = "Account Settings"
  erb :account
end

get '/login_twitter' do
  redirect to("/auth/twitter")
end

get '/auth/twitter/callback' do
  auth = request.env["omniauth.auth"]
  auth ? session[:handle] = env['omniauth.auth']['extra']['raw_info']['screen_name'] : halt(401,'Not Authorized')
  redirect '/account'
end
