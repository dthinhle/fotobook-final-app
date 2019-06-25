require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get signin" do
    get welcome_signin_url
    assert_response :success
  end

end
