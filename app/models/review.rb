class Review < ApplicationRecord
  validates :company_name, presence: true
  validates :channel, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }

  scope :by_company, ->(company) { where(company_name: company) if company.present? }
  scope :by_channels, ->(channels) { where(channel: channels) if channels.present? }
  scope :by_ratings, ->(ratings) { where(rating: ratings) if ratings.present? }
  scope :in_date_range, ->(from, to) {
    where(review_date: from..to) if from.present? && to.present?
  }
  scope :search_description, ->(q) {
    where("description ILIKE ?", "%#{q}%") if q.present?
  }
end
