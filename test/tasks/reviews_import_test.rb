class ReviewsImportTaskTest < ActiveSupport::TestCase
  setup do
    Rake.application.rake_require("tasks/reviews")
    Rake::Task.define_task(:environment)
  end

  test "import task is idempotent" do
    Rake::Task["reviews:import"].invoke
    initial_count = Review.count

    Rake::Task["reviews:import"].reenable
    Rake::Task["reviews:import"].invoke

    assert_equal initial_count, Review.count
  end
end
