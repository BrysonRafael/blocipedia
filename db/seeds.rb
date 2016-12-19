require 'random_data'

# Create Users
25.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
end
users = User.all

# Create Wikis
50.times do
  Wiki.create!(
    title: Faker::Hipster.sentence,
    body: Faker::Hipster.paragraph
  )
end
wikis = Wiki.all

puts "Seed finished"
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"
