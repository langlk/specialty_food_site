FactoryBot.define do
  factory(:product) do
    name("New Product")
    cost(5)
    origin("United States of America")
  end

  factory(:review) do
    author("Test")
    rating(3)
    content_body("Lorem ipsum dolor sit amet, consectetur adipiscing volutpat.")
    product_id(nil)
  end
end
