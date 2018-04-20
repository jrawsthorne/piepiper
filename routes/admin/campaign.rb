class PiePiper < Sinatra::Base

get '/campaigns' do
	admin!
	@title = "Campaigns"
	erb :'/pages/campaigns'
end

# get '/singlecampaign' do
# 	admin!
# 	@title = "SingleCampaign"
# 	erb :'/pages/singlecampaign'
# end

get '/allcampaigns' do
	admin!
	@title = "AllCampaigns"
	erb :'/pages/allcampaigns'
end

post '/campaigns' do
	if(authenticated?)
		 tweet=$client.update(params[:message])
		 reward_type = params[:reward]
		 winner_number = params[:winner_number]
		 campaign = Campaign.new do |u|
		 	u.campaign_type_id = reward_type
		 	u.tweet_id = tweet.id
		 	u.winner_number = winner_number
		 end
		 campaign.save

	else
		redirect('/')
	end
end

post '/allcampaigns' do
    campaign = Campaign.find(params[:campaign_id])
    ids = campaign.get_retweet_ids
    return ids.to_json
end


end
