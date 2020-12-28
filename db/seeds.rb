# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

fav_rubyists = [
  { username: "skmetz" },
  { username: "matz" },
  { username: "dhh" }
]

fav_rubyists.each do |user|
  User.create!(github_username: user[:username], password: "password")
end

