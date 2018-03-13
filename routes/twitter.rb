class PiePiper < Sinatra::Base
  get '/login_twitter' do
    redirect to("/auth/twitter")
  end

  get '/auth/twitter/callback' do
    auth = request.env["omniauth.auth"]
    if(User.exists?(twitter_id: auth.uid))
      user = User.find_by(twitter_id: auth.uid)
      auth ? session[:user_id] = user.id : halt(401,'Not Authorized')
      redirect '/'
    else
      flash[:twitter_id] = auth.uid
      redirect '/signup'
    end
  end
end
