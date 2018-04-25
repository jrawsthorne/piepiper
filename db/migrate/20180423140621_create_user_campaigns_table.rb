class CreateUserCampaignsTable < ActiveRecord::Migration[5.1]
  def change
  	create_table :user_campaigns do |t|
  		t.datetime :created_at
  		t.datetime :updated_at
  	end
  	add_reference :user_campaigns, :user
  	add_reference :user_campaigns, :campaign
  end
end
