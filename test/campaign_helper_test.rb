require_relative './test_helper'
require_relative '../helpers/campaign_helper'

class MyTest < Minitest::Test

  include Rack::Test::Methods

  def app
    PiePiper
  end

  def test_new_campaign
    new_campaign(1,1234,2)
    u = Campaign.find_by(tweet_id: 1234)
    assert_equal u.campaign_type_id, "1"
    assert_equal u.tweet_id, "1234"
    assert_equal u.winner_number, 2
    u.destroy
  end

end
