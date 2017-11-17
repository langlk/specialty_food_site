class Product < ActiveRecord::Base
  validates :name, :cost, :origin, presence: true
end
