require_relative './test_helper'

class MyTest < Minitest::Test

  include Rack::Test::Methods

  def app
    PiePiper
  end

  def test_display_currency
    get '/login'
    assert last_response.ok?
    assert_equal display_currency(10.20), "£10.20"
  end
end
