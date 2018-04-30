class PiePiper < Sinatra::Base

  #Authenticates user and sets variables to be passed to the page
  get '/login' do
    if(authenticated?)
      redirect '/account'
    end
    @title = "Login"
    @js = ['/scripts/login.js', 'https://maps.googleapis.com/maps/api/js?key=AIzaSyAtL0gTPJvWpKL5vwRGDmFM0zHedJq1BCU']
    @error = flash[:error]
    erb :'/user/login'
  end

  #Logs the user in, setting sessions or rejecting the attempt
  post '/login' do
    user = User.find_by_username(params[:username])
    if !user.nil? && user.password == params[:password]
      session[:location_id] = user.location_id
      session[:user_id] = user.id
      redirect '/'
    else
      flash[:error] = "Incorrect credentials"
      redirect '/login'
    end
  end
end
