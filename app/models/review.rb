class Review < ActiveRecord::Base
  validates :author, :content_body, :rating, presence: true
end
