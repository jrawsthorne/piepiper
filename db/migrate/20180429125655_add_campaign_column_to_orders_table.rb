class AddCampaignColumnToOrdersTable < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders, :campaign_id, :integer
  end
end
