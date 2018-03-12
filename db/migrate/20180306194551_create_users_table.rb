class CreateUsersTable < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :firstname
      t.string :lastname
      t.string :password
      t.string :twitter_id
      t.string :address
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_reference :users, :special_condition
    add_reference :users, :account_type
  end
end