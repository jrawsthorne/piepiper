class PiePiper < Sinatra::Base
  get '/signup' do
    if(session[:user_id])
      redirect('/account')
    end
    @title = "Sign up"
    # get the twitter user from the session if the session exists
    @js = ['/scripts/address.js','https://maps.googleapis.com/maps/api/js?key=AIzaSyAtL0gTPJvWpKL5vwRGDmFM0zHedJq1BCU&callback=initialize&libraries=places,geometry']
    @twitter_user = $client.user(flash[:twitter_id].to_i) if flash[:twitter_id]
    @special_conditions = SpecialCondition.all
    @locations = Location.all
    @error = flash[:error]
    @values = flash[:values]
    # redirect the user to twitter login if there isn't a twitter id in the session
    redirect('/auth/twitter') if(!@twitter_user)
    flash[:twitter_id] = flash[:twitter_id]
    erb :'/user/signup'
  end

  post '/signup' do
    if(params[:password] != params[:passwordconf])
      @error = 'Passwords don\'t match'
    elsif(params[:street] == "" || params[:house] == "")
      @error = 'Fill in address'
    end
    if(!@error)
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
        params[:location],
        params[:password]
            )
        redirect("/")
    else
      flash[:error] = @error
      flash[:values] = params
      flash[:twitter_id] = flash[:twitter_id]
      redirect('/signup')
    end
  end
end
