class CreateUsersCampaignsTable < ActiveRecord::Migration[5.1]
  def change
  	create_table :users_campaigns do |t|
  		t.datetime :created_at
  		t.datetime :updated_at
  	end
  	add_reference :users_campaigns, :user
  	add_reference :users_campaigns, :campaigns
  end
end
