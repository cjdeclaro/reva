require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  test "valid review" do
    review = Review.new(
      company_name: "TestCo",
      channel: "Airbnb",
      rating: 5,
      review_date: Date.today,
      title: "Great stay!",
      description: "Clean and comfy"
    )
    assert review.valid?
  end

  test "invalid without company_name" do
    review = Review.new(
      channel: "Airbnb",
      rating: 4,
      review_date: Date.today,
      title: "Missing company",
      description: "No company name"
    )
    assert_not review.valid?
    assert_includes review.errors[:company_name], "can't be blank"
  end

  test "invalid rating out of range" do
    review = Review.new(
      company_name: "TestCo",
      channel: "Airbnb",
      rating: 7, # invalid
      review_date: Date.today,
      title: "Invalid rating",
      description: "Rating too high"
    )
    assert_not review.valid?
    assert_includes review.errors[:rating], "is not included in the list"
  end
end
