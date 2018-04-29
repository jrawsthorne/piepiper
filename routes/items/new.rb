class PiePiper < Sinatra::Base	
	post '/items/new' do
		locations = []
		if params[:locations].nil?
			Location.all.each do |l|
				locations.push(l.id.to_s)
			end
		else
			locations = params[:locations]
		end
		new_item(
			params[:name],
			params[:price],
			params[:type],
			params[:speccond],
			locations)
	redirect '/'
	end

	get '/items/new' do
	    admin!
	    @title = "Items"
	    @item_types = ItemType.all
	    @items = Item.all
	    @special_conditions = SpecialCondition.all
	    erb :'/items/new'
  	end
end