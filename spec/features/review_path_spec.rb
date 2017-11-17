require "rails_helper"

describe "the review management path" do
  it "allows a user to create a new review" do
    product = Product.create(name: "New Product", cost: 5, origin: "United States of America")
    visit product_reviews_path(product)
    click_link "Write a Review"
    fill_in "Author", with: "Test"
    fill_in "Rating", with: 5
    fill_in "review_content_body", with: "Lorem ipsum dolor sit amet, consectetur adipiscing volutpat."
    click_on "Create Review"
    expect(page).to have_content("Lorem ipsum dolor sit amet, consectetur adipiscing volutpat.")
  end

  it "allows user to edit a review" do
    product = Product.create(name: "New Product", cost: 5, origin: "United States of America")
    review = product.reviews.create(author: "Anonymous", rating: 4, content_body: "Lorem ipsum dolor sit amet, consectetur adipiscing volutpat.")
    visit edit_product_review_path(product, review)
    fill_in "Author", with: "Bob Bobbington"
    click_on "Update Review"
    expect(page).to have_no_content("Anonymous")
    expect(page).to have_content("Bob Bobbington")
  end

  it "allows user to delete a review" do
    product = Product.create(name: "New Product", cost: 5, origin: "United States of America")
    review = product.reviews.create(author: "Anonymous", rating: 4, content_body: "Lorem ipsum dolor sit amet, consectetur adipiscing volutpat.")
    visit product_reviews_path(product)
    click_on "Delete"
    visit product_reviews_path(product)
    expect(page).to have_no_content("Anonymous")
  end

  it "displays errors if review form is not correctly completed" do
    product = Product.create(name: "New Product", cost: 5, origin: "United States of America")
    visit new_product_review_path(product)
    click_on("Create Review")
    expect(page).to have_content("Something went wrong!")
  end
end
