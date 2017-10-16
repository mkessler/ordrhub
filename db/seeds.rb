# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Source.create(name: 'GrubHub')
Source.create(name: 'eat24')
Source.create(name: 'UberEats')

Organization.create(name: 'Jersey Mike\'s')
Store.create(
  organization: Organization.first,
  name: 'Store #12345'
)
Store.create(name: 'Good Food on Montford')
User.create(
  email: 'user1@example.com',
  password: 'password'
)
User.create(
  email: 'user2@example.com',
  password: 'password'
)

Membership.create(
  organization: Organization.first,
  user: User.first
)
Association.create(
  store: Store.last,
  user: User.first
)
Association.create(
  store: Store.last,
  user: User.last
)

10.times do
  Order.create(
    source: Source.all.sample,
    store: Store.all.sample,
    details: {
      number: "1234567890",
      customer_name: "Scarlett Johannson",
      customer_phone: "555-987-6543",
      delivery_date: "May 29, 2017",
      delivery_address: "400 5th Ave Room 10234",
      delivery_time: "10:05 PM",
      delivery_city: "New York, NY 10018",
      items: [
        "1 Focaccia Della Casa $ 4.50",
        "1 Ensalata Caprese $ 9.00",
        "1 Pizza Quattro Formaggi $ 14.00"
      ],
      subtotal: "$27.50",
      fee: "$2.00",
      tax: "$2.62",
      tip: "$4.82",
      total: "$36.94",
      received: "2017-05-29T14:36:36.895831+00:00"
    }
  )
end
