class PiePiper < Sinatra::Base

get '/campaigns/new' do
	admin!
	@title = "Campaigns"
	@campaign_types = CampaignType.all
	erb :'/pages/campaigns'
end

# get '/singlecampaign' do
# 	admin!
# 	@title = "SingleCampaign"
# 	erb :'/pages/singlecampaign'
# end

get '/campaigns/all' do
	admin!
	@title = "All Campaigns"
	@campaigns = Campaign.all
	erb :'/pages/allcampaigns'
end

post '/campaigns/new' do
	if(authenticated?)
		 tweet=$client.update(params[:message])
		 reward_type = params[:reward]
		 winner_number = params[:winner_number]
		 campaign = Campaign.new do |u|
		 	u.campaign_type_id = reward_type
		 	u.tweet_id = tweet.id
		 	u.winner_number = winner_number
		 	u.closed = false
		 end
		 campaign.save
		 redirect('/campaigns/all')
	else
		redirect('/')
	end
end

post '/campaigns/all' do
    campaign = Campaign.find(params[:campaign_id])
    ids = campaign.get_retweet_ids
    winner_number = campaign.get_winner_number

    #the winner_index is randomly selected
    if winner_number == 0
    	winner_index = Random.rand(ids.length)
    elsif ids.length < winner_number
    	winner_index = ids.length - 1
    else
    	winner_index = winner_number - 1
    end
    winner = ids[winner_index]
    winner_account = User.where(twitter_id: winner)

    users_campaigns = UsersCampaigns.new do |u|
    	u.user_id = winner_account[0].get_id
    	u.campaigns_id = campaign.get_id
    end
    users_campaigns.save

    campaign.update_attribute(:closed, true)
    redirect('/campaigns/all')
end


end
