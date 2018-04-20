class CreateCampaignTypesTable < ActiveRecord::Migration[5.1]
  def change
  	create_table :campaign_types do |t|
  		t.string :type_name
  		t.integer :percentage_reduced
  	end
  end
end
