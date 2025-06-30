require "test_helper"

class NpsScoresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get nps_scores_path
    assert_response :success
  end
end
