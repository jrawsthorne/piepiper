class RemoveUserSpecialConditionIdColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :special_condition_id, :integer
  end
end