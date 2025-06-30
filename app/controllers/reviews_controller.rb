class ReviewsController < ApplicationController
  include Pagy::Backend

  def index
    @q = Review.all
    @q = @q.where(rating: params[:ratings]) if params[:ratings].present?
    @q = @q.where(channel: params[:channels]) if params[:channels].present?
    @q = @q.where(company_name: params[:company_name]) if params[:company_name].present?
    @q = @q.where(review_date: params[:from_date]..params[:to_date]) if params[:from_date].present? && params[:to_date].present?
    @q = @q.where("description ILIKE ?", "%#{params[:q]}%") if params[:q].present?

    @pagy, @reviews = pagy(@q.order(review_date: :desc))
  end
end
