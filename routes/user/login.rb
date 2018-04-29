class PiePiper < Sinatra::Base
  get '/login' do
    if(authenticated?)
      redirect '/account'
    end
    @title = "Login"
    @js = ['/scripts/login.js', 'https://maps.googleapis.com/maps/api/js?key=AIzaSyAtL0gTPJvWpKL5vwRGDmFM0zHedJq1BCU']
    @error = flash[:error]
    erb :'/user/login'
  end

  post '/login' do
    user = User.find_by_username(params[:username])
    session[:location_id] = user.location_id
    if !user.nil? && user.password == params[:password]
      session[:user_id] = user.id
      redirect '/'
    else
      flash[:error] = "Incorrect credentials"
      redirect '/login'
    end
  end
end
