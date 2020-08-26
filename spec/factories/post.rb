FactoryBot.define do
  factory :book, class: Post do
    title { Faker::Lorem.characters(number:5) }
    author { Faker::Lorem.characters(number:5) }
    subject { Faker::Lorem.characters(number:5) }
    body { Faker::Lorem.characters(number:20) }
    user { create(:user) }
    category {Category.create(category: '小説')}
  end

  factory :movie, class: Post do
    title { Faker::Lorem.characters(number:5) }
    subject { Faker::Lorem.characters(number:5) }
    body { Faker::Lorem.characters(number:20) }
    user { create(:user) }
    category {Category.create(category: '映画')}
  end
end
