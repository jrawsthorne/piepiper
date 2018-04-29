require_relative './test_helper'

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
  
  def test_check_input
    refute check_input(['Pork pie'], [1])
    assert_equal check_input(['New pie'], [1]), "Item 'New pie' doesn't exist"
    assert_equal check_input([], [1]), 'Mismatch'
    assert_equal check_input(['Pork pie'], []), 'Mismatch'
    assert_equal check_input(['Pork pie'], [-1]), 'Invalid quantity'
  end

  def test_new_order
    items = ['Pork pie']
    quantities = [1]
    tweet_id = 989109475557691392
    
    new_order(items, quantities, tweet_id)
    
    u = Order.last
    
    assert_equal u.tweet_id, tweet_id.to_s
    assert_equal u.user_id, 3
    assert_equal u.order_state_id, 1
    assert_equal u.location_id, 1

    items.each do |item|
      assert OrderItem.where(['order_id = :order AND item_id = :item AND quantity = :quantity', { order: u.id, item: 1, quantity: 1 }]).length > 0
      OrderItem.where(['order_id = :order AND item_id = :item AND quantity = :quantity', { order: u.id, item: 1, quantity: 1 }]).each do |item|
        item.destroy
      end
    end
    
    u.destroy

  end

end
