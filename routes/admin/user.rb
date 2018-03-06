get '/user/:user_id' do
  authenticate!
  user_id = params['user_id']
  if(User.exists?(user_id))
    @title = "User - "+User.find(user_id).fullname
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