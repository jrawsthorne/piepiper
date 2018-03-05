get '/' do
  @title = "Menu"
  erb :index
end

get '/about' do
  @title = "About Us"
  erb :about
end

get '/login' do
  @title = "Login"
  erb :login
end

post '/login' do
  # Accepts any credentials for now
  session[:user] = "username"
  redirect '/orders'
end

get '/logout' do
  session[:user] = nil
  redirect '/'
end

not_found do
  redirect '/'
end