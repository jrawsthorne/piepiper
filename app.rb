require 'sinatra'
require 'twitter'

before do
  config = {
      :consumer_key => '...',
      :consumer_secret => '...',
      :access_token => '...',
      :access_token_secret => '...'
  }
  @client = Twitter::REST::Client.new(config)
end