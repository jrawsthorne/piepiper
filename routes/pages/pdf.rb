class PiePiper < Sinatra::Base
  get '/tablepdf' do
    Item.write_to_pdf()
    file = File.open('price_list.pdf')
    send_file(file, :disposition => 'attachment', :filename => File.basename(file))
    redirect '/'
  end
end