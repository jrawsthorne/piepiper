class PiePiper < Sinatra::Base
  get '/' do
    @title = "Menu"
    @item_types = ItemType.all
    @special_conditions = SpecialCondition.all
    @items = Item.all
    erb :'/pages/index'
  end

  get '/about' do
    @title = "About Us"
    erb :'/pages/about'
  end

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
    if(session[:location_id] === nil)
      session[:location_id] = Location.first.id
    end
    user = User.find_by_username(params[:username])
    if !user.nil? && user.password == params[:password]
      session[:user_id] = user.id
      #Pony.mail({
      #  :to => 'jake@jakerawsthorne.co.uk',
      #  :from => 'no-reply@pie-piper.me',
      #  :subject => 'Logged in',
      #  :body => 'Thanks for loggin in '+user.fullname,
      #  :via => :smtp,
      #  :via_options => {
      #    :address              => 'smtp.zoho.eu',
      #    :port                 => '587',
      #    :user_name            => 'no-reply@pie-piper.me',
      #    :password             => 'sb3I5S7Cj9*5',
      #    :authentication       => :plain,
      #    :enable_starttls_auto => true,
      #  }
      #})
      redirect '/'
    else
      flash[:error] = "Incorrect credentials"
      redirect '/login'
    end
  end

  get '/signup' do
    @title = "Sign up"
    # get the twitter user from the session if the session exists
    @twitter_user = $client.user(flash[:twitter_id].to_i) if flash[:twitter_id]
    @special_conditions = SpecialCondition.all
    # redirect the user to twitter login if there isn't a twitter id in the session
    redirect('/auth/twitter') if(!@twitter_user)
    erb :'/user/signup'
  end

  get '/account' do
    authenticate!
    @js =['/scripts/address.js','https://maps.googleapis.com/maps/api/js?key=AIzaSyAtL0gTPJvWpKL5vwRGDmFM0zHedJq1BCU&callback=initialize&libraries=places,geometry']
    @title = "Account Settings"
    @user = get_user_from_session
    @twitter_user = $client.user(@user.twitter_id.to_i) if @user.twitter_id
    @special_conditions = SpecialCondition.all
    erb :'/user/account'
  end

  get '/logout' do
    session[:user_id] = nil
    session[:location_id] = nil
    redirect '/'
  end
  
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
    
  get '/tablepdf' do
    Item.write_to_pdf()
    file = File.open('price_list.pdf')
    send_file(file, :disposition => 'attachment', :filename => File.basename(file))
    redirect '/'
  end

  not_found do
    redirect '/'
  end
end
