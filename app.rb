require 'sinatra'
require 'twitter'
require "sqlite3"
require 'json'

enable :sessions

before do
  config = {
      :consumer_key => 'vqJ9GQDOns00WAQx7oDoBJqFX',
      :consumer_secret => 'HmlsBdLGWcZXcFCiidsq74AlLr2XWJnKaO09QPxMWN24ZdpxjK',
      :access_token => '965615031185485824-xCVnWm6q628bwhbLcFjhAsGCpPojDKT',
      :access_token_secret => 'ilEkrfVAahr8odgafGkodNkRl045MbbSgeoicL4x80EB8'
  }
  @client = Twitter::REST::Client.new(config)
  @db = "piepiper.db"
end

def get_items
  items = []
  db = SQLite3::Database.new @db
  # Gets item name and type by joining data from two ItemTypes and Items tables
  stm = db.prepare "SELECT Items.Name,ItemTypes.Name FROM Items INNER JOIN ItemTypes ON ItemTypes.ID = Items.Type"
  rs = stm.execute
  while (row = rs.next) do
      items.push(row[0]) # Only pulls item name for now, not item type 
  end
  return items;
  stm.close if stm
  db.close if db
end

def new_order(items, tweet_id)
  user_id = @client.status(tweet_id).user.id
  db = SQLite3::Database.new @db
  # Creates new order
  db.execute("INSERT INTO Orders (User, Tweet) 
              VALUES (?, ?)", [user_id, tweet_id])
  new_order_id = db.last_insert_row_id()
  items.each do |item|
    # Inserts into OrderItems the OrderID from the order added above and the item name from the form
    db.execute("INSERT INTO OrderItems (`Order`, Item) VALUES (?, (SELECT ID FROM Items WHERE Name = ?))", [new_order_id, item])
  end
  db.close
end

def get_orders  
  orders = Hash.new
  db = SQLite3::Database.new @db
  stmt = db.prepare "SELECT ID FROM Orders"
  rs = stmt.execute
  rs.each do |row|
    items = []
    # Gets item name from Items based on ID from OrderItems ItemID
    stmt2 = db.prepare "SELECT Items.Name FROM OrderItems INNER JOIN Items ON Items.ID = OrderItems.Item WHERE Order=?"
    stmt2.bind_params(row)
    rs2 = stmt2.execute
    rs2.each do |row|
      items.push(row.join)
    end
    stmt2.close
    orders[row.join] = items
  end
  stmt.close
  db.close
  return orders
end

def current_class?(test_path)
    request.path == test_path ? 'active' : ''
end

def authenticate!
    unless session[:user]
      redirect '/login'
    end
end

def authenticated?
    !!session[:user]
end

get '/' do
  @title = "Menu"
  erb :index
end

get '/about' do
  @title = "About Us"
  erb :about
end

get '/login' do
  @title = "Login"
  erb :login
end

post '/login' do
  # Accepts any credentials for now
  session[:user] = "username"
  redirect '/orders'
end

get '/logout' do
  session[:user] = nil
  redirect '/'
end

get '/orders' do
  authenticate!
  @title = "Orders"
  erb :orders
end

post '/new-order/:tweet_id' do
  authenticate!
  new_order(params[:item], params[:tweet_id])
  redirect '/orders'
end

get '/new-order' do
  authenticate!
  redirect '/orders'
end

get '/new-order/:tweet_id' do
  authenticate!
  @title = "New order"
  erb :'new-order'
end

post '/edit-order/:tweet_id' do
  authenticate!
  puts params[:item]
  redirect '/orders'
end

get '/edit-order' do
  authenticate!
  redirect '/orders'
end

get '/edit-order/:tweet_id' do
  authenticate!
  @title = "Edit order"
  erb :'edit-order'
end

get '/delete-order/:tweet_id' do
  authenticate!
  redirect '/orders'
end

get '/delete-order' do
  authenticate!
  redirect '/orders'
end

not_found do
  redirect '/'
end

# Just for testing

get '/api/get-items' do
  content_type :json
  items = get_items
  {:items => items }.to_json
end

def parse_orders(orders)
  get_orders.each do |key, array|
    array.each do |item|
      puts "Item ID: "+key
      puts "Item Name: "+item
    end
  end
end

get '/api/get-orders' do
  parse_orders(get_orders)
  content_type :json
  {:orders => get_orders }.to_json
end
