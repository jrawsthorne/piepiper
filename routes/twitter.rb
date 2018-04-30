class PiePiper < Sinatra::Base

  #Redirects the user to appropriate page
  get '/login_twitter' do
    redirect to("/auth/twitter")
  end

  #Uses the user's twitter ID to sign them in, or redirect them to the sign-up page
  get '/auth/twitter/callback' do
    auth = request.env["omniauth.auth"]
    if(User.exists?(twitter_id: auth.uid))
      user = User.find_by(twitter_id: auth.uid)
      auth ? session[:user_id] = user.id : halt(401,'Not Authorized')
      session[:location_id] = user.location_id
      redirect '/'
    else
      flash[:twitter_id] = auth.uid
      redirect '/signup'
    end
  end
end
