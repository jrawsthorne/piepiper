class PiePiper < Sinatra::Base

  #Displays the About page
  get '/about' do
    @title = "About Us"
    @js = ['/scripts/about.js', 'https://maps.googleapis.com/maps/api/js?key=AIzaSyAtL0gTPJvWpKL5vwRGDmFM0zHedJq1BCU&callback=initialize&libraries=places']
    erb :'/pages/about'
  end
end
