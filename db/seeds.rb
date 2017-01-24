# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# db/seeds.rb

1000.times do |i|
  Shop.create!(
    name:    "店名#{i}",
    zipcode: "111-#{sprintf("%04d", i)}",
    address: "住所#{i}",
    tel:     "00-1234-#{sprintf("%04d", i)}"
  )
end