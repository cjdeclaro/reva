require "test_helper"

class NpsScoreTest < ActiveSupport::TestCase
  test "valid NPS score" do
    score = NpsScore.new(
      company_name: "TestCo",
      date: Date.yesterday,
      promoters_count: 10,
      passives_count: 5,
      detractors_count: 3
    )
    assert score.valid?
  end

  test "invalid without date" do
    score = NpsScore.new(
      company_name: "TestCo",
      promoters_count: 1,
      passives_count: 1,
      detractors_count: 1
    )
    assert_not score.valid?
    assert_includes score.errors[:date], "can't be blank"
  end
end
