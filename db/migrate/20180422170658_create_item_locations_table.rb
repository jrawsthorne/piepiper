class CreateItemLocationsTable < ActiveRecord::Migration[5.1]
  def change
  	create_table :item_locations do |t|
  		t.datetime :created_at
  		t.datetime :updated_at
  	end
  	add_reference :item_locations, :item
  	add_reference :item_locations, :locations
  end
end
