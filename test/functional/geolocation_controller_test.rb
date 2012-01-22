require 'test_helper'

class GeolocationControllerTest < ActionController::TestCase
  test "should get fetch_block" do
    get :fetch_block
    assert_response :success
  end

end
