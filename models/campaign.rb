class Campaign < ActiveRecord::Base
	belongs_to :campaign_type
	def get_tweet
		begin
	    return $client.status(tweet_id.to_i, tweet_mode: "extended")
	  rescue Twitter::Error
	    return nil
	  end
  end
	def get_retweet_ids
		retweet_ids = $client.retweeters_ids(tweet_id, options = {})
		ids = []
		retweet_ids.each do |i|
			User.all.each do |u|
				if u.twitter_id.to_i == i.to_i
					ids.push(i)
				end
			end
		end
		return ids
	end
	def get_winner_number
		win_num = winner_number
		return win_num
	end
	def get_id
		return id
	end
end

class CampaignType < ActiveRecord::Base
end

class UserCampaign < ActiveRecord::Base
	belongs_to :user
	belongs_to :campaign
end