class PiePiper < Sinatra::Base	
  get '/items/delete/:item_id' do
    admin!
    item_id = params[:item_id]
    if(Item.exists?(item_id))
      item = Item.find(item_id)
      item.destroy
    end
    redirect '/'
  end
end