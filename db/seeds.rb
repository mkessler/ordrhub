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

50.times do
  Store.create(
    organization: Organization.first,
    name: "Store ##{Faker::Number.number(5)}"
  )
end

Store.create(name: 'Good Food on Montford')
Store.create(name: 'ROCKSALT')

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
  user: User.last
)
Association.create(
  store: Store.last,
  user: User.last
)

Store.all.each do |store|
  50.times do
    am_pm = rand(0..1)
    order_count = rand(1..5)
    order_objects = []
    order_count.times do
      order_objects << {
        item: Faker::Food.dish,
        amount: rand(2.99...18.99).round(2),
        count: rand(1..3)
      }
    end
    subtotal = order_objects.sum { |item| item[:amount] * item[:count] }
    fee = rand(2..4).round(2)
    tax = (subtotal * 0.07).round(2)
    tip = (subtotal * 0.18).round(2)
    total = (subtotal + fee + tax + tip).round(2)
    received = Faker::Time.between(DateTime.now, DateTime.now + 30)

    Order.create(
      source: Source.all.sample,
      store: store,
      details: {
        number: "#{Faker::Number.number(10)}",
        customer_name: "#{Faker::Name.name}",
        customer_phone: "#{Faker::PhoneNumber.phone_number}",
        delivery_date: received.strftime('%B %-d, %Y'),
        delivery_address: "#{Faker::Address.street_address}",
        delivery_time: "#{rand(1..12)}:#{sprintf('%02d',rand(1..12))} #{am_pm == 1 ? 'AM' : 'PM'}",
        delivery_city: "#{Faker::Address.city}, #{Faker::Address.state_abbr} #{Faker::Address.zip_code}",
        items: order_objects.map { |order|
          if order[:count] == 1
            "#{order[:count]} #{order[:item]} $#{order[:amount]}"
          else
            total_amount = (order[:amount] * order[:count]).round(2)
            "#{order[:count]} #{order[:item]} $#{total_amount} ($#{order[:amount]}/ea)"
          end
        },
        subtotal: "$#{sprintf('%.2f', subtotal)}",
        fee: "$#{sprintf('%.2f', fee)}",
        tax: "$#{sprintf('%.2f', tax)}",
        tip: "$#{sprintf('%.2f', tip)}",
        total: "$#{sprintf('%.2f', total)}",
        received: received.to_s
      }
    )
  end
end
