class PiePiper < Sinatra::Base

  get '/user/:user_id' do
    admin!
    user_id = params['user_id']
    if(User.exists?(user_id))
      @title = "User - "+User.find(user_id).fullname
      erb :'/user/user'
    else
      redirect('/')
    end
  end

  get '/users' do
    admin!
    @title = "Users"
    erb :'/user/users'
  end

  post '/users' do
    puts"---------------------------------------------"
    puts params
    redirect '/'
  end

end
