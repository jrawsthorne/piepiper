#Used to create a new user
def new_user(
  username, firstname, surname, email,
  house, street, postcode, twitter_handle, dietary_preferences, location, password)

  #Checks the locations exists
  if(Location.exists?(name: location))
    location_id = Location.find_by(name: location).id
  else
    location_id = Location.first.id
  end

  #Creates the new user in Users table
  user = User.new do |u|
    u.username = username.to_s
    u.firstname = firstname.to_s
    u.lastname = surname.to_s
    u.password = password
    u.twitter_id = flash[:twitter_id].to_s
    u.house = house.to_s
    u.street = street.to_s
    u.postcode = postcode.to_s
    u.account_type_id = 1
    u.email = email
    u.location_id = location_id
  end
  user.save

  #Sets the sessions for user ID and location
  session[:user_id] = user.id
  session[:location_id] = user.location_id
  dietary_preferences.each do |condition|
    user_special_condition = UserSpecialCondition.new do |u| #ERROR HERE
      u.user_id = session[:user_id]
      u.special_condition_id = condition
    end
    user_special_condition.save
  end

end

#Changes an existing user's fields
def update_user(forename, surname, email,
house, street, postcode, dietary_preferences, location)

  #Checks the passed location exists
  if(Location.exists?(name: location))
    location_id = Location.find_by(name: location).id
  else
    location_id = Location.first.id
  end

  #Finds the record of the currently logged in user and changes their fields to the passed values
  u = User.find(session[:user_id])
  u.firstname = forename.to_s
  u.lastname = surname.to_s
  u.house = house.to_s
  u.street = street.to_s
  u.postcode = postcode.to_s
  u.email = email
  u.location_id = location_id
  u.save

  #Sets the location ID session
  session[:location_id] = u.location_id

  #Deletes all users special conditions
  u.user_special_conditions.each do |condition|
    condition.destroy
  end

  #Assigns user's dietary preferences
  dietary_preferences.each do |condition|
    user_special_condition = UserSpecialCondition.new do |u| #ERROR HERE
      u.user_id = session[:user_id]
      u.special_condition_id = condition
    end
    user_special_condition.save
  end

end
