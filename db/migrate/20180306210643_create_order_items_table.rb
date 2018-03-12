class CreateOrderItemsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_reference :order_items, :item
    add_reference :order_items, :order
  end
end
