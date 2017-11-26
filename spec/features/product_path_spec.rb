require "rails_helper"

describe "the product management path" do
  it "allows user to add a product" do
    visit products_path
    click_link "Add a Product"
    fill_in "Name", with: "Test Product"
    fill_in "Cost", with: 10
    fill_in "Origin", with: "United States of America"
    click_on "Create Product"
    expect(page).to have_content("Test Product")
  end

  it "allows user to update a product" do
    product = Product.create(name: "New Product", cost: 5, origin: "United States of America")
    visit product_path(product)
    click_link "Edit"
    fill_in "Name", with: "Old Product"
    click_on "Update Product"
    expect(page).to have_no_content("New Product")
    expect(page).to have_content("Old Product")
  end

  it "allows user to delete a product" do
    product = Product.create(name: "New Product", cost: 5, origin: "United States of America")
    visit product_path(product)
    click_link "Delete"
    visit products_path
    expect(page).to have_no_content("New Product")
  end

  it "removes reviews associated with deleted product" do
    product = Product.create(name: "New Product", cost: 5, origin: "United States of America")
    review = product.reviews.create(
      author: "Test1",
      content_body: "Lorem ipsum dolor sit amet, consectetur adipiscing volutpat.",
      rating: 3
    )
    visit product_path(product)
    click_link "Delete"
    visit products_path
    expect { Review.find(review.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "displays errors if new product is missing fields" do
    visit new_product_path
    click_on "Create Product"
    expect(page).to have_content("Something went wrong!")
  end

  it "displays errors if updated product is missing fields" do
    product = Product.create(name: "New Product", cost: 5, origin: "United States of America")
    visit edit_product_path(product)
    fill_in "Name", with: ""
    click_on "Update Product"
    expect(page).to have_content("Something went wrong!")
  end

  it "displays only US-made products if selected" do
    product = Product.create(name: "New Product 1", cost: 5, origin: "United States of America")
    product = Product.create(name: "New Product 2", cost: 5, origin: "Canada")
    visit products_path
    select "US Products Only", from: "method"
    click_on "Apply"
    expect(page).to have_no_content("New Product 2")
    expect(page).to have_content("New Product 1")
  end

  it "displays the most recent products on the landing page" do
    product = Product.create(name: "New Product 1", cost: 5, origin: "United States of America")
    product = Product.create(name: "New Product 1.5", cost: 5, origin: "United States of America")
    product = Product.create(name: "New Product 2", cost: 5, origin: "Canada")
    product = Product.create(name: "New Product 3", cost: 5, origin: "Canada")
    product = Product.create(name: "New Product 4", cost: 5, origin: "Canada")
    visit root_path
    expect(page).to have_content("New Product 4")
    expect(page).to have_content("New Product 3")
    expect(page).to have_content("New Product 2")
  end
end
