class Product < ActiveRecord::Base
  has_many :reviews
  validates :name, :cost, :origin, presence: true

  scope :recent, -> { order(created_at: :desc).limit(3) }
  scope :most_reviewed, -> {(
    select("products.id, products.name, products.cost, products.origin, count(reviews.id) as reviews_count")
    .left_outer_joins(:reviews)
    .group("products.id")
    .order("reviews_count DESC")
    .first
  )}
  scope :usa_made, -> { where(origin: "United States of America") }

  def rating
    if self.reviews.any?
      rating_total = self.reviews.reduce(0) do |total, review|
        total + review.rating
      end
      return rating_total.to_f / self.reviews.length
    else
      return nil
    end
  end
end
