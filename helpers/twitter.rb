=begin
post '/signup' do
  new_user(
    params[:username],
    params[:firstname],
    params[:lastname],
    params[:password],
    params[:twitter_handle],
    params[:dietaryrequirements],
    params[:house_number],
    params[:address_line_1],
    params[:address_line_2],
    params[:city_region],
    params[:postcode]
          )
end
=end

def new_user(username, firstname, lastname, password,
            twitter_id, special_conditions,
            house_number, address_line_1, address_line_2,
            city_region, postcode)
  user = User.new do |u|
    u.username = username
    u.firstname = firstname
    u.lastname = lastname
    u.password = "password"
    u.twitter_id = twitter_id.to_s
    special_conditions.each do |condition|

    end
    u.house_number = house_number
    u.address_line_1 = address_line_1
    u.address_line_2 = address_line_2
    u.city_region = city_region
    u.postcode = postcode
    u.account_type_id = 1
  end
  user.save
  session[:user_id] = user.id
  puts session[:user_id]
end
