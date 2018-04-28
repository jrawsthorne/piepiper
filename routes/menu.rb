class PiePiper < Sinatra::Base
  get '/' do
    @js = []
    if((!params[:location] && !session[:location_id]) || (params[:location] && !Location.exists?(name: params[:location])))
      @js.push('/scripts/menu.js', 'https://maps.googleapis.com/maps/api/js?key=AIzaSyAtL0gTPJvWpKL5vwRGDmFM0zHedJq1BCU')
    elsif(!params[:location])
      @location = Location.find(session[:location_id])
    else
      @location = Location.find_by(name: params[:location])
    end
    if(!@location)
      @title = "Menu loading"
      erb :'/pages/loading'
    else
      @js.push('/scripts/locationChanger.js')
      @title = "Menu"
      @item_types = ItemType.all
      @special_conditions = SpecialCondition.all
      @items = @location.items
      @locations = Location.all
      @isAdmin = get_account_type_from_session == 3
      erb :'/pages/menu'
    end
  end
  
  post '/get-location' do
    payload = params
    payload = JSON.parse(request.body.read).symbolize_keys unless params[:path]
    city = payload[:city]
    if(payload[:city].empty?)
      location = Location.first
      session[:location_id] = location.id
      return location.name.to_json
      status 200
    elsif(Location.exists?(name: city))
      session[:location_id] = Location.find_by(name: city).id
      return city.to_json
      status 200
    else
      location = Location.first
      return location.name.to_json
      status 200
    end
  end

end