class CreateCampaignsTable < ActiveRecord::Migration[5.1]
  def change
  	create_table :campaigns do |t|
  	  t.string :campaign_type_id
  	  t.string :tweet_id
  	  t.integer :winner_number
  	  t.datetime :created_at
      t.datetime :updated_at
    end
end
end
