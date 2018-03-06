def authenticate!
    unless session[:user_id]
      redirect '/login'
    end
end

def authenticated?
    !!session[:user_id]
end

def get_user_from_session
  return User.find(session[:user_id]) if session[:user_id]
end