post '/signup' do
  puts(
    params[:username],
    params[:forename],
    params[:surname],
    params[:email],
    params[:address_line_1],
    params[:address_line_2],
    params[:postcode],
    params[:city_region],
    params[:twitter_handle],
    params[:diet]
        )
end

=begin
def new_user(username, forename, surname, email, address_line_1, 
  address_line_2, postcode, city_region, twitter_handle, 
  meat_preference, nut_allergy, dairy_allergy, gluten_allergy)

  user = User.new do |u|
    u.username = username
    u.firstname = firstname
    u.lastname = lastname
    u.password = "password"
    u.twitter_id = twitter_id.to_s

    #special_conditions

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

def get_id_by_condition(condition)
  SpecialCondition.where(name: condition).pluck(:id).join
end

<% @items.select{|item| item.special_condition_id == special_condition.id}.each do |item| %>
=end