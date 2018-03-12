module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
      
    when /the login page/
      '/login'
      
    when /the signup page/
      '/signup'
      
    when /the account page/
      '/account'
      
    when /the orders page/
      '/orders'
      
    when /the about page/
      '/about'
      
    when /the users page/
      '/users'
      
    when /the logout page/
      '/logout'
      
    when /the new_order page/
      '/new-order/968523084159438848'
    
    when /the new_order_not_tweet page/
      '/new-order/9685230841'
      
    when /the page_does_not_exist page/
      '/page_does_not_exist'
      
    when /the api_get_items page/
      '/api/get-items'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"

    end
  end
end

World(NavigationHelpers)