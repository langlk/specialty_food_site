require "rails_helper"

describe Product do
  it { should validate_presence_of :name }
  it { should validate_presence_of :cost }
  it { should validate_presence_of :origin }
  it { should validate_numericality_of(:cost).is_greater_than(0) }

  it { should have_many :reviews }

  describe '.recent' do
    it "should return the 3 most recently added products" do
      p1 = FactoryBot.create(:product)
      p2 = FactoryBot.create(:product)
      p3 = FactoryBot.create(:product)
      p4 = FactoryBot.create(:product)
      expect(Product.recent).to eq([p4, p3, p2])
    end
  end

  describe '.most_reviewed' do
    it "should return the product with the most reviews" do
      p1 = FactoryBot.create(:product)
      p2 = FactoryBot.create(:product)
      p3 = FactoryBot.create(:product)
      FactoryBot.create(:review, product_id: p2.id)
      FactoryBot.create(:review, product_id: p2.id)
      FactoryBot.create(:review, product_id: p1.id)
      expect(Product.most_reviewed).to eq(p2)
    end
  end

  describe '.usa_made' do
    it "should return all products of USA origin" do
      p1 = FactoryBot.create(:product)
      p2 = FactoryBot.create(:product, origin: "Canada")
      p3 = FactoryBot.create(:product)
      expect(Product.usa_made).to eq([p1, p3])
    end
  end

  describe '#rating' do
    it "returns the average rating of a product" do
      p1 = FactoryBot.create(:product)
      FactoryBot.create(:review, product_id: p1.id, rating: 3)
      FactoryBot.create(:review, product_id: p1.id, rating: 4)
      FactoryBot.create(:review, product_id: p1.id, rating: 2)
      expect(p1.rating).to eq(3)
    end
  end
end
