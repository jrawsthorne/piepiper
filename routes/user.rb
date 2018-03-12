get '/' do
  @title = "Menu"
  @item_types = ItemType.all
  @special_conditions = SpecialCondition.all
  @items = Item.all
  erb :index
end

get '/about' do
  @title = "About Us"
  erb :about
end

get '/login' do
  if(authenticated?)
    redirect '/'
  else
    @title = "Login"
    erb :login
  end
end

post '/login' do
  # Sign in as Colin for now
  session[:user_id] = 1
  redirect '/orders'
end

get '/signup' do
  @title = "Sign up"
  erb :signup
end

get '/account' do
  authenticate!
  @title = "Account Settings"
  @user = get_user_from_session
  @twitter_user = $client.user(@user.twitter_id.to_i)
  @special_conditions = SpecialCondition.all
  erb :account
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

not_found do
  redirect '/'
end
