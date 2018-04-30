class PiePiper < Sinatra::Base

  #Clears the session for the current user
  get '/logout' do
    session[:user_id] = nil
    session[:location_id] = nil
    redirect '/'
  end
end
