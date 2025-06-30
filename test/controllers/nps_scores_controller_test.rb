require "test_helper"

class NpsScoresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get nps_scores_index_url
    assert_response :success
  end
end
