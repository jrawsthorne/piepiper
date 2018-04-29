class PiePiper < Sinatra::Base
	get '/campaigns/all' do
		admin!
		@title = "All Campaigns"
		@campaigns = Campaign.all
		erb :'/campaigns/all'
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
	    winner_account = User.find_by(twitter_id: winner)

	    user_campaigns = UserCampaign.new do |u|
	    	u.user_id = winner_account.get_id
	    	u.campaign_id = campaign.get_id
	    end
	    
		$client.update("@"+$client.user(winner).screen_name+" you have won a piepiper "+ campaign.get_type_name + " competition, order now to use your reward", )	   
	    user_campaigns.save

	    campaign.update_attribute(:closed, true)
	    redirect('/campaigns/all')
	end
end