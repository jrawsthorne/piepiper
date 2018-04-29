class PiePiper < Sinatra::Base	
  get '/items/edit/:item_id' do
    admin!
    item_id = params[:item_id]
    @item = Item.find(item_id)
    @special_conditions = SpecialCondition.all
    @item_types = ItemType.all
    @title = "Edit item"
    if(@item.special_condition_id == nil)
      @special_condition_id = 1
    else
      @special_condition_id = @item.special_condition_id
    end
    @item_location_ids = []
    @item.item_locations.each do |item_location|
      @item_location_ids.push(item_location.location.id)
    end
    erb :'/items/edit'
  end
  get '/items/edit/' do
    redirect('/')
  end
  post '/items/edit/:item_id' do
    admin!
    if(Item.find(params[:item_id]))
      locations = []
  		if params[:locations].nil?
  			Location.all.each do |l|
  				locations.push(l.id.to_s)
  			end
  		else
  			locations = params[:locations]
  		end
      Item.find(params[:item_id]).edit_item(
        params[:name],
        params[:price],
        params[:type],
        params[:speccond],
        locations
      )
    end
	redirect '/'
  end
end