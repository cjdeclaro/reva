class NpsRollupJob < ApplicationJob
  queue_as :default

  def perform
    target_date = Date.yesterday
    companies = Review.where(review_date: target_date).distinct.pluck(:company_name)

    companies.each do |company|
      reviews = Review.where(company_name: company, review_date: target_date)
      promoters = reviews.where(rating: 5).count
      passives = reviews.where(rating: 4).count
      detractors = reviews.where("rating <= 3").count

      NpsScore.create!(
        company_name: company,
        date: target_date,
        promoters_count: promoters,
        passives_count: passives,
        detractors_count: detractors
      )
    end
  end
end
