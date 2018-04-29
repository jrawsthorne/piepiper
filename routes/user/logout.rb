class PiePiper < Sinatra::Base
  get '/logout' do
    session[:user_id] = nil
    session[:location_id] = nil
    redirect '/'
  end
end