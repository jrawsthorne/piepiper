class PiePiper < Sinatra::Base

get '/campaigns/new' do
	admin!
	@title = "Campaigns"
	erb :'/pages/campaigns'
end

# get '/singlecampaign' do
# 	admin!
# 	@title = "SingleCampaign"
# 	erb :'/pages/singlecampaign'
# end

get '/campaigns/all' do
	admin!
	@title = "AllCampaigns"
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
		 end
		 campaign.save

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
    return winner.to_json
end


end
