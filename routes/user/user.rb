class PiePiper < Sinatra::Base

  get '/user/:user_id' do
    admin!
    user_id = params['user_id']
    if(User.exists?(user_id))
      @title = "User - "+User.find(user_id).fullname
      # find the user by id based on the URL parameter
      @user = User.find(params['user_id'])
      # get the twitter account from the user
      @twitter_user = @user.get_twitter_user
      @user_special_conditions = @user.user_special_conditions
      @account_types = AccountType.all
      @orders = @user.orders
      @js = ['/scripts/users.js']
      erb :'/user/user'
    else
      redirect('/')
    end
  end

  get '/users' do
    admin!
    @title = "Users"
    # get all users from database
    @users = User.all
    @account_types = AccountType.all
    @js = ['/scripts/users.js']
    erb :'/user/users'
  end

  post '/users' do
    redirect '/'
  end

  get '/reset-password' do
    if(authenticated?)
      redirect('/account')
    else
      @title = "Reset password"
      erb :'/user/reset'
    end
  end

  post '/reset-password' do
    if(User.exists?(email: params[:email]))
      user = User.find_by(email: params[:email])
      user.generate_token
      Pony.mail({
        :to => user.email,
        :from => 'no-reply@pie-piper.me',
        :subject => 'Reset Password for PiePiper',
        :body => 'Please click this link to reset your password: '+'http://localhost:4567/reset-password/'+user.password_reset_token,
        :via => :smtp,
        :via_options => {
          :address              => 'smtp.zoho.eu',
          :port                 => '587',
          :user_name            => 'no-reply@pie-piper.me',
          :password             => 'sb3I5S7Cj9*5',
          :authentication       => :plain,
          :enable_starttls_auto => true,
        }
      })
    end
  end

  post '/change-user-type' do
    data = params
    data = JSON.parse(request.body.read).symbolize_keys unless params[:path]
    u = User.find(data[:userId].to_i)
    u.account_type_id = data[:accountTypeId]
    u.save
    return
  end

end
