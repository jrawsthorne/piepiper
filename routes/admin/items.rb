class PiePiper < Sinatra::Base	
	post '/items' do
		locals = []
		if params[:locals].nil?
			Location.all.each do |l|
				locals.push(l.id.to_s)
			end
		else
			locals = params[:locals]
		end
		new_item(
			params[:name],
			params[:price],
			params[:type],
			params[:speccond],
			locals)
	redirect '/items'
	end

	get '/items' do
	    admin!
	    @title = "Items"
	    @item_types = ItemType.all
	    @items = Item.all
	    @special_conditions = SpecialCondition.all
	    erb :'/pages/items'
  	end
end