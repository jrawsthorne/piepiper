require 'sinatra'
require 'sinatra/flash'
require 'sinatra/activerecord'
require 'twitter'
require 'json'
require 'omniauth-twitter'
require_relative 'models/init'
require_relative 'helpers/init'
require_relative 'routes/init'

set :database, "sqlite3:db/piepiper.db"

use OmniAuth::Builder do
  provider :twitter, 'vqJ9GQDOns00WAQx7oDoBJqFX', 'HmlsBdLGWcZXcFCiidsq74AlLr2XWJnKaO09QPxMWN24ZdpxjK'
end

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

get '/test' do
  erb :test
end
