class Review < ActiveRecord::Base
  belongs_to :product

  validates :author, :content_body, :rating, :product, presence: true
  validates :rating, inclusion: { in: 1..5 }
end
