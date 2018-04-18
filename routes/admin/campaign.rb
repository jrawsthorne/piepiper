class PiePiper < Sinatra::Base

get '/campaigns' do
	admin!
	@title = "Campaigns"
	erb :'/pages/campaigns'
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
