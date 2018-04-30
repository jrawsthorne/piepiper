#Checks if the user is logged in
def authenticate!
    session[:user_id] = nil if(!User.exists?(session[:user_id]))
    unless session[:user_id]
      redirect '/login'
    end
end

#
def authenticated?
    !!session[:user_id]
end

#Returns the user based on who is logged in
def get_user_from_session
  return User.find(session[:user_id]) if session[:user_id]
end

#Returns the user's account type of the logged in user
def get_account_type_from_session
  return User.where(id: session[:user_id]).pluck(:account_type_id).join.to_i if session[:user_id]
end

#Checks if the user is an admin
def admin!
  check_account_type(3)
end

#Checks if the user is an order handler
def order_handler!
  check_account_type(2);
end

#Checks what account type the user is
def check_account_type(account_type_id)
  authenticate!
  unless(get_account_type_from_session >= account_type_id)
    flash[:error] = "Unauthorised access, you've been signed out"
    session[:user_id] = nil
    redirect '/login'
  end
end

#Returns a random string of 30 characters
def get_random_string
  length=30
  source=("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a + ["_","-"]
  key=""
  length.times{ key += source[rand(source.size)].to_s }
  return key
end
