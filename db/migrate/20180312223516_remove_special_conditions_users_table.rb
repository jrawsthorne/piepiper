class RemoveSpecialConditionsUsersTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :special_conditions_users
  end
end
