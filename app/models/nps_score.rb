class NpsScore < ApplicationRecord
  validates :company_name, presence: true
  validates :date, presence: true
  validates :promoters_count, :passives_count, :detractors_count,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  def self.for_yesterday
    where(date: Date.yesterday)
  end
end
