require_relative './test_helper'

class MyTest < Minitest::Test

  include Rack::Test::Methods
  
  def test_get_items_with_prices
    assert_equal get_items_with_prices(1), {"Pork pie"=>10.0, "Lamb shank pie"=>10.0, "Mash"=>2.0, "Gravy"=>2.0, "Coke"=>1.0, "Strawberry milkshake"=>3.5, "Cider"=>5.7, "Sea bass puff pie"=>10.5, "Lemon Meringue pie"=>10.0, "Kale, Chestnut and Mushroom pie"=>10.5, "Venison & Bacon pie"=>10.0, "Pineapple pie"=>10.5, "Apple pie"=>10.5, "Feta Spinach pie"=>10.5, "Mushroom Asparagus pie"=>10.5, "Chicken & Leek pie"=>10.5, "Coleslaw"=>2.0, "Chips/Fries"=>2.0, "Mac n Cheese"=>2.0, "Diet coke"=>1.0, "Fanta"=>1.0, "Vanilla milkshake"=>3.5, "Chocolate milkshake"=>3.5, "Lager"=>5.7}
  end

  def test_new_item
    locations = [2,3]
    new_item("New pie",10.0,1,1,locations)
    u = Item.last
    assert_equal u.name, "New pie"
    assert_equal u.price, 10.0
    assert_equal u.item_type_id, 1
    assert_equal u.special_condition_id, 1

    locations.each do |location_id|
      assert ItemLocation.where(['location_id = :location AND item_id = :item', { location: location_id, item: u.id }]).length > 0
      ItemLocation.where(['location_id = :location AND item_id = :item', { location: location_id, item: u.id }]).each do |item_location|
        item_location.destroy
      end
    end
    
    u.destroy

  end

end
