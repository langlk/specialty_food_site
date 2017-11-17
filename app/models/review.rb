class Review < ActiveRecord::Base
  belongs_to :product
  validates :author, :content_body, :rating, :product, presence: true
end
