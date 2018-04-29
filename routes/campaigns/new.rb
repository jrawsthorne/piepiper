class PiePiper < Sinatra::Base
	get '/campaigns/new' do
		admin!
		@title = "Campaigns"
		@campaign_types = CampaignType.all
		erb :'/campaigns/new'
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
end