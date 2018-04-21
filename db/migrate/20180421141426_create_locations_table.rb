class CreateLocationsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
