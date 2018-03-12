class CreateItemsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.float :price
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_reference :items, :item_type
    add_reference :items, :special_condition
  end
end
