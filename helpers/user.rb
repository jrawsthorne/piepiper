def authenticate!
    unless session[:user]
      redirect '/login'
    end
end

def authenticated?
    !!session[:user]
end

def get_account_type(id: nil, name: nil)
  return AccountType.new(id,name)
end
  
def get_account_types
  account_types = []
  query = $db.prepare "SELECT ID FROM AccountTypes"
  results = query.execute
  while (row = results.next) do
      account_types.push(get_account_type(id: row.join))
  end
  return account_types;
  query.close if query
end

def get_user(id: nil, twitter_id: nil, username: nil)
  return User.new(id, twitter_id, username)
end

def get_users(account_type: nil, dietry_requirements: nil)
  users = []
  if(account_type == nil && dietry_requirements == nil)
    query = $db.prepare "SELECT ID FROM Users"
  elsif(account_type == nil)
    query = $db.prepare "SELECT ID FROM Users WHERE DietryRequirements = CAST(? as INTEGER)"
    query.bind_params(dietry_requirements.id)
  else
    query = $db.prepare "SELECT ID FROM Users WHERE AccountType = CAST(? as INTEGER)"
    query.bind_params(account_type.id)
  end
  results = query.execute
  while (row = results.next) do
      users.push(get_user(id: row.join))
  end
  return users;
  query.close if query
end

def isuser(twitter_id: nil, user_id: nil)
  if(twitter_id == nil)
    return !get_user(id: user_id).twitter_id.nil?
  else
    return !get_user(twitter_id: twitter_id).id.nil?
  end
end