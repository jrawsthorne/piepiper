class AddClosedColumnToCampaignsTable < ActiveRecord::Migration[5.1]
  def change
  	add_column :campaigns, :closed, :boolean
  end
end
