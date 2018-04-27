

require_relative './test_helper'
require_relative '../helpers/general'

class MyTest < Minitest::Test

  include Rack::Test::Methods

  def app
    PiePiper
  end

  def test_get_user_from_tweet
    assert_equal get_user_from_tweet(989166642117652480), 965615031185485824
  end

  def test_display_currency
    assert_equal display_currency(10.20), "£10.20"
  end

end
