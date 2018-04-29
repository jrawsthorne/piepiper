class PiePiper < Sinatra::Base
  get '/menu' do
    if(!params[:location] || !Location.exists?(name: params[:location]))
      location_id = Location.first.id
    else
      location_id = Location.find_by(name: params[:location]).id
    end
    write_to_pdf(location_id)
    file = File.open(Location.find(location_id).name+'_price_list.pdf')
    send_file(file, :disposition => 'attachment', :filename => File.basename(file))
    redirect '/'
  end
end