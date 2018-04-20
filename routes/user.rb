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
      flash[:error] = "You're already signed in"
    end
    @title = "Login"
    erb :'/user/login'
  end

  post '/login' do
    user = User.find_by_username(params[:username])
    if !user.nil? && user.password == params[:password]
      session[:user_id] = user.id
      redirect '/'
    else
      flash[:error] = "Incorrect credentials"
      redirect('/login')
    end
  end

  get '/signup' do
    @title = "Sign up"
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
    redirect '/'
  end

  not_found do
    redirect '/'
  end
end
