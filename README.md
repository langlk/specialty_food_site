# Specialty Food Site

### _Epicodus Project in Ruby on Rails, November 17, 2017_

### By Kelsey Langlois

## Description

_This is a mock website for an online food supplier. It allows users to create, view, edit, and delete food products and reviews for those food products. It also features a filter for products originally from the United States, and a landing page where users can see the most reviewed and newest products added._

## Set-up/Installation Instructions

* Clone this repository
* From the project root directory, run the following commands:
  * **Note: seeding the database will remove all existing data and replace it.**
  ```
  bundle install
  rake db:create
  rake db:migrate
  rake db:seed
  rake db:test:prepare
  rails s
  ```
* You can then access the app in your web browser at ```localhost:3000```

## Specifications

* Products
  * Users can see a product's name, cost, country of origin, and rating
  * Users can create, read, update, and destroy products
  * Users can filter products by those originating in the United States of America
    * _Note that this filters by the full name, "United States of America", as used in [Faker's](https://github.com/stympy/faker) Address collection._
  * Users can view the newest products
  * Users can view the most-reviewed product
* Reviews
  * Users can see a review's author, rating, and content
  * Users can create, read, update, and destroy reviews for a product

## Support and contact details

_Please contact [kels.langlois@gmail.com](mailto:kels.langlois@gmail.com) with questions, comments, or issues._

## Technologies Used

* Ruby
* Rails
* Bootstrap

### License

Copyright (c) 2017 **Kelsey Langlois**

*This software is licensed under the MIT license.*
