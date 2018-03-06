get '/' do
  @title = "Menu"
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
  erb :account
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

not_found do
  redirect '/'
end
