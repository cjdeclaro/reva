require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reviews_path
    assert_response :success
  end
end
