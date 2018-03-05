require 'sinatra'
require_relative 'models/init'
require_relative 'helpers/init'
require_relative 'routes/init'
require 'twitter'
require 'sqlite3'
require 'json'

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