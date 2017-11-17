class Product < ActiveRecord::Base
  has_many :reviews
  validates :name, :cost, :origin, presence: true

  scope :recent, -> { order(created_at: :desc).limit(3) }
  scope :most_reviewed, -> {(
    select("products.id, products.name, products.cost, products.origin, count(reviews.id) as reviews_count")
    .joins(:reviews)
    .group("products.id")
    .order("reviews_count DESC")
    .first
  )}
end