class CreateOrdersTable < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :tweet_id
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_reference :orders, :user
    add_reference :orders, :order_state
  end
end