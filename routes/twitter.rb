class PiePiper < Sinatra::Base
  get '/login_twitter' do
    redirect to("/auth/twitter")
  end

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

  post '/signup' do
    if params[:diet].nil?
      diet = [1]
    else
      diet = params[:diet]
    end
    new_user(
      params[:username],
      params[:firstname],
      params[:surname],
      params[:email],
      params[:house],
      params[:street],
      params[:postcode],
      flash[:twitter_id],
      diet,
      params[:location]
          )
      redirect("/")
  end

end
