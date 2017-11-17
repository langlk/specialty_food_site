class Product < ActiveRecord::Base
  has_many :reviews
  validates :name, :cost, :origin, presence: true

  scope :recent, -> { order(created_at: :desc).limit(3) }
end
