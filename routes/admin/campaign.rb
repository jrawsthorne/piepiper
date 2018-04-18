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
		 puts tweet.id
	else
		redirect('/')
	end
end

end
