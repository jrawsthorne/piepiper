class PiePiper < Sinatra::Base
  get '/login_twitter' do
    redirect to("/auth/twitter")
  end

  get '/auth/twitter/callback' do
    auth = request.env["omniauth.auth"]
    if(User.exists?(twitter_id: auth.uid))
      user = User.find_by(twitter_id: auth.uid)
      auth ? session[:user_id] = user.id : halt(401,'Not Authorized')
      Pony.mail({
        :to => 'jake@jakerawsthorne.co.uk',
        :from => 'no-reply@pie-piper.me',
        :subject => 'Logged in',
        :body => 'Thanks for loggin in '+user.fullname,
        :via => :smtp,
        :via_options => {
          :address              => 'smtp.zoho.eu', 
          :port                 => '587',                 
          :user_name            => 'no-reply@pie-piper.me',
          :password             => 'sb3I5S7Cj9*5',         
          :authentication       => :plain,
          :enable_starttls_auto => true,
        }
      })
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
      params[:forename],
      params[:surname],
      params[:email],
      params[:address_line_1],
      params[:address_line_2],
      params[:postcode],
      params[:city_region],
      flash[:twitter_id],
      diet
          )
      redirect("/")
  end

end
