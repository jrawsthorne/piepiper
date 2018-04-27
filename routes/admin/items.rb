class PiePiper < Sinatra::Base	
	post '/items' do
		locals = []
		puts "+++++++++++++++++++++++++++" + params[:locals].to_json
		if params[:locals].nil?
			Location.all.each do |l|
				locals.push(l.id.to_s)
			end
			puts "+++++++++++++++++++++++++++" + locals.to_json
		else
			locals = params[:locals]
		end
		new_item(
			params[:name],
			params[:price],
			params[:type],
			params[:speccond],
			locals)
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