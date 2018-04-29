require_relative './test_helper'

require_relative '../app'

class MyTest < Minitest::Test

  include Rack::Test::Methods
  
  def setup
    config = {
        :consumer_key => 'vqJ9GQDOns00WAQx7oDoBJqFX',
        :consumer_secret => 'HmlsBdLGWcZXcFCiidsq74AlLr2XWJnKaO09QPxMWN24ZdpxjK',
        :access_token => '965615031185485824-xCVnWm6q628bwhbLcFjhAsGCpPojDKT',
        :access_token_secret => 'ilEkrfVAahr8odgafGkodNkRl045MbbSgeoicL4x80EB8'
    }
    $client = Twitter::REST::Client.new(config)
  end

  def test_display_currency
    assert_equal display_currency(10.20), "£10.20"
  end
  
  def test_display_error
    assert_equal display_error('An error'), '<div class="col-md-12 error"><div class="alert alert-danger col-sm-12" role="alert">An error</div></div>'
  end
  
  def test_display_success
    assert_equal display_success('Success'), '<div class="col-md-12 success"><div class="alert alert-success col-sm-12" role="alert">Success</div></div>'
  end
  
  def test_is_tweet
    assert istweet(989109475557691392)
    refute istweet(832974892478927489723894629647254)
  end
  
  def test_get_user_from_tweet
    assert_equal get_user_from_tweet(989109475557691392), 965615031185485824
  end
  
end
