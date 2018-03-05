get '/user/:user_id' do
  authenticate!
  user_id = params['user_id']
  if(isuser(user_id: user_id))
    @title = "User - "+get_user(id: user_id).fullname
    erb :user
  else 
    redirect('/')
  end
end

get '/users' do
  authenticate!
  @title = "Users"
  erb :users
end