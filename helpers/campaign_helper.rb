
def new_campaign(
	campaign_type_id, tweet_id,
	winner_number)

	campaign = Campaign.new do |u|
		u.campaign_type_id = campaign_type_id.to_i
		u.tweet_id = tweet_id.to_i
		u.winner_number = winner_number.to_i
	end
	campaign.save
end
