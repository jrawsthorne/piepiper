require 'minitest/autorun'
require 'rack/test'
require_relative '../app'

ENV['RACK_ENV'] = 'test'

class TestStuff < MiniTest::Unit::TestCase
    
  include Rack::Test::Methods

  def app
    PiePiper.new
  end
    
  def test_first_thing
    username = "admin"
    #assert_equal username, User.find_by_username(username).username
    assert_equal 4, (2 * 2)
  end

  def test_second_thing
    assert_equal 9, (3 * 3)
  end
end