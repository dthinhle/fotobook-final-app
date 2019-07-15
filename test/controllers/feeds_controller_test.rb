require 'test_helper'

class FeedsControllerTest < ActionDispatch::IntegrationTest
  test "should get following" do
    get feed_following_url
    assert_response :success
  end

end
