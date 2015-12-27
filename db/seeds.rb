# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name: 'Admin user',
             email: 'admin@memocity.cl',
             mobile_num: '56964257820',
             password: 'foobar',
             password_confirmation: 'foobar',
             activated: true,
             activated_at: Time.zone.now,
             admin: true)

10.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@memocity.cl"
  mobile_num = "5696425781#{n}"
  password = 'password'
  User.create!(name: name,
               email: email,
               mobile_num: mobile_num,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do |i|
  content = Faker::Lorem.sentence(5)
  users.each do |user|
    user.reminders.create!(content: content,
                           when_activate: i+3.hours.from_now)
  end
end
