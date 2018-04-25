def new_user(
  username, forename, surname, email, 
  address_line_1,  address_line_2, postcode, 
  city_region, twitter_handle, dietary_preferences)

  user = User.new do |u|
    u.username = username.to_s
    u.firstname = forename.to_s
    u.lastname = surname.to_s
    u.password = "password"
    u.twitter_id = flash[:twitter_id].to_s
    u.address = address_line_1.to_s
    #u.address_line_2 = address_line_2.to_s
    #u.city_region = city_region.to_s
    #u.postcode = postcode.to_s
    u.account_type_id = 1
  end
  user.save

  session[:user_id] = user.id
  puts( 
    session[:user_id].to_s+"____________",
    username,
    forename,
    surname,
    email,
    address_line_1,
    address_line_2,
    postcode,
    city_region,
    flash[:twitter_id],
    dietary_preferences )

  dietary_preferences.each do |condition|
    user_special_condition = UserSpecialCondition.new do |u| #ERROR HERE
      u.user_id = session[:user_id]
      u.special_condition_id = condition
    end
    user_special_condition.save
  end

end