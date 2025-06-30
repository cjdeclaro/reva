class ReviewsController < ApplicationController
  include Pagy::Backend

  def index
    @ratings     = Review.distinct.pluck(:rating).sort
    @channels    = Review.distinct.pluck(:channel).sort
    @companies   = Review.distinct.pluck(:company_name).sort

    reviews = Review.all

    reviews = reviews.where(rating: params[:ratings]) if params[:ratings].present?
    reviews = reviews.where(channel: params[:channels]) if params[:channels].present?
    reviews = reviews.where(company_name: params[:company]) if params[:company].present?
    reviews = reviews.where(review_date: params[:from]..params[:to]) if params[:from].present? && params[:to].present?
    reviews = reviews.where("description ILIKE ?", "%#{params[:q]}%") if params[:q].present?

    @pagy, @reviews = pagy(reviews.order(review_date: :desc))

    # Get average ratings per day from last 30 review dates
    subquery_dates = reviews
      .select(:review_date)
      .distinct
      .order(review_date: :desc)
      .limit(30)

    @chart_data = reviews
      .where(review_date: subquery_dates)
      .group(:review_date)
      .order(review_date: :asc)
      .pluck(:review_date, Arel.sql("ROUND(AVG(rating)::numeric, 2)"))
      .to_h
      .transform_keys { |date| date.strftime("%b %-d") }
  end
end
