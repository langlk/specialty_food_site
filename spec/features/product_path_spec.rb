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
    save_and_open_page
    expect(page).to have_no_content("New Product")
  end

  it "displays errors if product is missing fields" do
    visit new_product_path
    click_on "Create Product"
    expect(page).to have_content("Something went wrong!")
  end
end
