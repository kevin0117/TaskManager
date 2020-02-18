FactoryBot.define do
  factory :user do
    username { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { 'password' }

    trait :normal_user do
      admin { false }
    end
    trait :admin_user do
      admin { true }
    end
  end
end
