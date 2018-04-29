class PiePiper < Sinatra::Base
  get '/account' do
    authenticate!
    @js =['/scripts/address.js','https://maps.googleapis.com/maps/api/js?key=AIzaSyAtL0gTPJvWpKL5vwRGDmFM0zHedJq1BCU&callback=initialize&libraries=places,geometry']
    @title = "Account Settings"
    @user = get_user_from_session
    @twitter_user = $client.user(@user.twitter_id.to_i) if @user.twitter_id
    @special_conditions = SpecialCondition.all
    @campaigns = Campaign.all
    @user_campaigns = @user.user_campaigns
    @campaign_types = CampaignType.all
    @error = flash[:error]
    erb :'/user/account'
  end

  post '/account' do
    authenticate!
      if(params[:house] = "" || params[:street] = "")
        @error = 'Fill in address'
      end
      if(!@error)
        if params[:diet].nil?
          diet = [1]
        else
          diet = params[:diet]
        end
        update_user(
          params[:firstname],
          params[:surname],
          params[:email],
          params[:house],
          params[:street],
          params[:postcode],
          diet,
          params[:location]
              )
          redirect('/')
      else
        flash[:error] = @error
        flash[:values] = params
        flash[:twitter_id] = flash[:twitter_id]
        redirect('/account')
      end
    end
end
