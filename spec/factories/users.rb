FactoryBot.define do
  factory :user do
    username { Faker::Name.first_name }
    email { Faker::Internet.email }
    id { Faker::Number.between(from: 1, to: 3) }
  end
end
