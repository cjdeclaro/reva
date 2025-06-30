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
  end
end
