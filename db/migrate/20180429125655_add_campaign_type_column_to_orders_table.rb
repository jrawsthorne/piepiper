class AddCampaignTypeColumnToOrdersTable < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders, :campaign_type_id, :integer
  end
end
