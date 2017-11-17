require "rails_helper"

describe Product do
  it { should validate_presence_of :name }
  it { should validate_presence_of :cost }
  it { should validate_presence_of :origin }

  it { should have_many :reviews }

  describe '.recent' do
    it "should return the 3 most recently added products" do
      p1 = Product.create(name: "Test1", cost: 1, origin: "Test1")
      p2 = Product.create(name: "Test2", cost: 2, origin: "Test2")
      p3 = Product.create(name: "Test3", cost: 1, origin: "Test3")
      p4 = Product.create(name: "Test4", cost: 1, origin: "Test4")
      expect(Product.recent).to eq([p4, p3, p2])
    end
  end

  describe '.most_reviewed' do
    it "should return the product with the most reviews" do
      p1 = Product.create(name: "Test1", cost: 1, origin: "Test1")
      p2 = Product.create(name: "Test2", cost: 2, origin: "Test2")
      p3 = Product.create(name: "Test3", cost: 1, origin: "Test3")

      p2.reviews.create(
        author: "Test1",
        content_body: "Lorem ipsum dolor sit amet, consectetur adipiscing volutpat.",
        rating: 3
      )
      p2.reviews.create(
        author: "Test2",
        content_body: "Lorem ipsum dolor sit amet, consectetur adipiscing volutpat.",
        rating: 4
      )
      p1.reviews.create(
        author: "Test3",
        content_body: "Lorem ipsum dolor sit amet, consectetur adipiscing volutpat.",
        rating: 3
      )
      expect(Product.most_reviewed).to eq(p2)
    end
  end
end