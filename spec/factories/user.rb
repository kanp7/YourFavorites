FactoryBot.define do
  factory :user do
    name { Faker::Internet.username(specifier: 5..6) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number:20)}
    password { "password" }
    password_confirmation { "password" }
  end
end