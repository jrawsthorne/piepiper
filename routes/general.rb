class PiePiper < Sinatra::Base

  #Handles setting the user's location
  post '/get-location' do
    payload = params
    payload = JSON.parse(request.body.read).symbolize_keys unless params[:path]
    city = payload[:city]

    #If the location passed is empty
    if(!city || city.empty?)
      location = Location.first
      session[:location_id] = location.id
      return location.name.to_json
      status 200

    #If the location exists
    elsif(Location.exists?(name: city))
      session[:location_id] = Location.find_by(name: city).id
      return city.to_json
      status 200
    else
      location = Location.first
      return location.name.to_json
      status 200
    end
  end

  #Sets the location session if the location is valid and in the database
  post '/set-location' do
    payload = params
    payload = JSON.parse(request.body.read).symbolize_keys unless params[:path]
    city = payload[:city]
    if(Location.exists?(name: city))
      location = Location.find_by(name: city)
      session[:location_id] = location.id
      status 200
    else
      location = Location.first
      session[:location_id] = 1
      status 200
    end
  end

  #Sends a tweet based on posted data
  post '/send-tweet' do
    payload = params
    payload = JSON.parse(request.body.read).symbolize_keys unless params[:path]
    if(authenticated?)
      tweet = $client.update("@"+payload[:user]+" "+payload[:tweet], in_reply_to_status_id: payload[:in_reply_to].to_i)
      if tweet.truncated? && tweet.attrs[:extended_tweet]
        tweet_text = tweet.attrs[:extended_tweet][:full_text]
      else
        tweet_text = tweet.attrs[:text] || tweet.attrs[:full_text]
      end
      return {
          created_at: tweet.created_at.asctime,
          tweet_text: tweet_text,
          user: {
            profile_image_url: tweet.user.profile_image_url.to_s,
            full_name: User.find_by(twitter_id: tweet.user.id).fullname
          }
      }.to_json
    else
      content_type :json
      status 400
      return {error: "Unauthorised"}.to_json
    end
  end
  not_found do
    redirect '/'
  end
end
