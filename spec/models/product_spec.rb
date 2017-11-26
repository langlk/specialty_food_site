require "rails_helper"

describe Product do
  it { should validate_presence_of :name }
  it { should validate_presence_of :cost }
  it { should validate_presence_of :origin }
  it { should validate_numericality_of(:cost).is_greater_than(0) }

  it { should have_many :reviews }

  describe '.recent' do
    it "should return the 3 most recently added products" do
      p1 = FactoryGirl.create(:product)
      p2 = FactoryGirl.create(:product)
      p3 = FactoryGirl.create(:product)
      p4 = FactoryGirl.create(:product)
      expect(Product.recent).to eq([p4, p3, p2])
    end
  end

  describe '.most_reviewed' do
    it "should return the product with the most reviews" do
      p1 = FactoryGirl.create(:product)
      p2 = FactoryGirl.create(:product)
      p3 = FactoryGirl.create(:product)

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

  describe '.usa_made' do
    it "should return all products of USA origin" do
      p1 = FactoryGirl.create(:product)
      p2 = FactoryGirl.create(:product, origin: "Canada")
      p3 = FactoryGirl.create(:product)
      expect(Product.usa_made).to eq([p1, p3])
    end
  end

  describe '#rating' do
    it "returns the average rating of a product" do
      p1 = FactoryGirl.create(:product)
      p1.reviews.create(
        author: "Test1",
        content_body: "Lorem ipsum dolor sit amet, consectetur adipiscing volutpat.",
        rating: 3
      )
      p1.reviews.create(
        author: "Test2",
        content_body: "Lorem ipsum dolor sit amet, consectetur adipiscing volutpat.",
        rating: 4
      )
      p1.reviews.create(
        author: "Test3",
        content_body: "Lorem ipsum dolor sit amet, consectetur adipiscing volutpat.",
        rating: 2
      )
      expect(p1.rating).to eq(3)
    end
  end
end
