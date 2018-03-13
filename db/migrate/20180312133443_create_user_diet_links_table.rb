class CreateUserDietLinksTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :special_conditions
    
  end
end
