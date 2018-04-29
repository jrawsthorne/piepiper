class CreateHiddenTweetsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :hidden_tweets do |t|
      t.string :tweet_id
  		t.datetime :created_at
  		t.datetime :updated_at
  	end
  end
end
