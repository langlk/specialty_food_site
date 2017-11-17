class Product < ActiveRecord::Base
  has_many :reviews
  validates :name, :cost, :origin, presence: true
end
