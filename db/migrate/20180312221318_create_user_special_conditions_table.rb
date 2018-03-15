class CreateUserSpecialConditionsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :user_special_conditions do |t|
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_reference :user_special_conditions, :special_condition
    add_reference :user_special_conditions, :user
  end
end
