def new_user(
  username, firstname, surname, email,
  house, street, postcode, twitter_handle, dietary_preferences)

  user = User.new do |u|
    u.username = username.to_s
    u.firstname = firstname.to_s
    u.lastname = surname.to_s
    u.password = "password"
    u.twitter_id = flash[:twitter_id].to_s
    u.house = house.to_s
    u.street = street.to_s
    u.postcode = postcode.to_s
    u.account_type_id = 1
    u.email = email
  end
  user.save

  session[:user_id] = user.id
  dietary_preferences.each do |condition|
    user_special_condition = UserSpecialCondition.new do |u| #ERROR HERE
      u.user_id = session[:user_id]
      u.special_condition_id = condition
    end
    user_special_condition.save
  end

end

def update_user(forename, surname, email,
house, street, postcode, dietary_preferences)

  u = User.find(session[:user_id])
  u.firstname = forename.to_s
  u.lastname = surname.to_s
  u.house = house.to_s
  u.street = street.to_s
  u.postcode = postcode.to_s
  u.email = email
  u.save

  dietary_preferences.each do |condition|
    user_special_condition = UserSpecialCondition.new do |u| #ERROR HERE
      u.user_id = session[:user_id]
      u.special_condition_id = condition
    end
    user_special_condition.save
  end

end
