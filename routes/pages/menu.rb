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
      @title = "Menu"
      @item_types = ItemType.all
      @special_conditions = SpecialCondition.all
      @items = @location.items
      @locations = Location.all
      @isAdmin = get_account_type_from_session == 3
      erb :'/pages/menu'
    end
  end
end