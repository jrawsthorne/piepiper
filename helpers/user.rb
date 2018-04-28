def authenticate!
    session[:user_id] = nil if(!User.exists?(session[:user_id]))
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

def get_account_type_from_session
  return User.where(id: session[:user_id]).pluck(:account_type_id).join.to_i if session[:user_id]
end

def admin!
  check_account_type(3)
end

def order_handler!
  check_account_type(2);
end

def check_account_type(account_type_id)
  authenticate!
  unless(get_account_type_from_session >= account_type_id)
    flash[:error] = "Unauthorised access, you've been signed out"
    session[:user_id] = nil
    redirect '/login'
  end
end
