require_relative './test_helper'
require_relative '../helpers/campaign_helper'

class MyTest < Minitest::Test

  include Rack::Test::Methods

  def app
    PiePiper
  end

  def test_new_item
    locations = [2,3]
    new_item("Lamb shank pie",10.0,1,1,locations)
    u = Item.last
    assert_equal u.name, "Lamb shank pie"
    assert_equal u.price, 10.0
    assert_equal u.item_type_id, 1
    assert_equal u.special_condition_id, 1
    # u.destroy

    locations.each do |location_id|
      assert ItemLocation.where(['location_id = :location AND item_id = :item', { location: location_id, item: u.id }]).length > 0
      u.destroy

    end

  end

end
