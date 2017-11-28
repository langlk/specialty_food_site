# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all
Review.destroy_all

prng = Random.new
products = []

50.times do
  products.push(Product.create!(
    name: Faker::Food.ingredient,
    cost: prng.rand(1..100),
    origin: Faker::Address.country
  ))
end

puts "Seeded #{Product.count} products."

250.times do
  product = products[prng.rand(products.length)]
  reviewtext = Faker::Lorem.sentence
  while reviewtext.length < 50
    reviewtext += Faker::Lorem.word
  end
  product.reviews.create!(
    author: Faker::Name.name,
    rating: prng.rand(1..5),
    content_body: reviewtext
  )
end


puts "Seeded #{Review.count} reviews."
