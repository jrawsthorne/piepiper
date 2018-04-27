
require_relative './test_helper'
require_relative '../helpers/general'

require_relative '../app'

class MyTest < Minitest::Test

  include Rack::Test::Methods


  def test_display_currency
    assert_equal General.display_currency(10.20), "£10.20"
  end

end
