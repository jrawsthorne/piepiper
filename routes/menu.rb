class PiePiper < Sinatra::Base
  get '/' do
    if(!params[:location])
      @js = ['/scripts/menu.js', 'https://maps.googleapis.com/maps/api/js?key=AIzaSyAtL0gTPJvWpKL5vwRGDmFM0zHedJq1BCU']
    end
    if(!params[:location] || !Location.exists?(name: params[:location]))
      @location = Location.first
    else
      @location = Location.find_by(name: params[:location])
    end
    @title = "Menu"
    @item_types = ItemType.all
    @special_conditions = SpecialCondition.all
    @items = @location.items
    @isAdmin = get_account_type_from_session == 3
    erb :'/pages/menu'
  end
  
  post '/get-location' do
    payload = params
    payload = JSON.parse(request.body.read).symbolize_keys unless params[:path]
    city = payload[:city]
    if(payload[:city].empty?)
      location = Location.first
      return location.name.to_json
      status 200
    elsif(Location.exists?(name: city))
      return city.to_json
      status 200
    else
      location = Location.first
      return location.name.to_json
      status 200
    end
  end

end