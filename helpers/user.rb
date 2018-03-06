def authenticate!
    session[:user_id] = nil if(!User.exists?(session[:user_id]))
    unless session[:user_id]
      redirect '/login'
    end
end

def authenticated?
    session[:user_id] = nil if(!User.exists?(session[:user_id]))
    !!session[:user_id]
end

def get_user_from_session
  return User.find(session[:user_id]) if session[:user_id]
end

def get_account_type_from_session
  return User.where(id: session[:user_id]).pluck(:account_type_id).join.to_i if session[:user_id]
end