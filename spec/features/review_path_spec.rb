require "rails_helper"

describe "the review management path" do
  it "allows a user to create a new review" do
    product = FactoryBot.create(:product)
    visit product_reviews_path(product)
    click_link "Write a Review"
    fill_in "Author", with: "Test"
    fill_in "review_rating", with: 5
    fill_in "review_content_body", with: "Lorem ipsum dolor sit amet, consectetur adipiscing volutpat."
    click_on "Create Review"
    expect(page).to have_content("Lorem ipsum dolor sit amet, consectetur adipiscing volutpat.")
  end

  it "allows user to edit a review" do
    product = FactoryBot.create(:product)
    review = FactoryBot.create(:review, product_id: product.id)
    visit edit_product_review_path(product, review)
    fill_in "Author", with: "Bob Bobbington"
    click_on "Update Review"
    expect(page).to have_no_content("Anonymous")
    expect(page).to have_content("Bob Bobbington")
  end

  it "allows user to delete a review" do
    product = FactoryBot.create(:product)
    review = FactoryBot.create(:review, product_id: product.id)
    visit product_reviews_path(product)
    click_on "Delete"
    visit product_reviews_path(product)
    expect(page).to have_no_content("Anonymous")
  end

  it "displays errors if new review form is not correctly completed" do
    product = FactoryBot.create(:product)
    visit new_product_review_path(product)
    click_on("Create Review")
    expect(page).to have_content("Something went wrong!")
  end

  it "displays errors if review edit form is not correctly completed" do
    product = FactoryBot.create(:product)
    review = FactoryBot.create(:review, product_id: product.id)
    visit edit_product_review_path(product, review)
    fill_in "Author", with: ""
    click_on("Update Review")
    expect(page).to have_content("Something went wrong!")
  end
end
