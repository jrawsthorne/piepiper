class Campaign < ActiveRecord::Base
	belongs_to :campaign_type
	def get_tweet
    return $client.status(tweet_id.to_i, tweet_mode: "extended")
  end
end

class CampaignType < ActiveRecord::Base
end
