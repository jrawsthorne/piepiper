class Campaign < ActiveRecord::Base
	belongs_to :campaign_type
	def get_tweet
    	return $client.status(tweet_id.to_i, tweet_mode: "extended")
  	end

  	def get_retweet_ids
		retweet_ids = $client.retweeters_ids(tweet_id, options = {})
		ids = []
		retweet_ids.each do |u|
			ids.push(u)
		end
	return ids
end 

end

class CampaignType < ActiveRecord::Base
end
