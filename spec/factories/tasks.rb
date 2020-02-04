# frozen_string_literal: true

# rubocop:disable Style/AsciiComments
FactoryBot.define do
  factory :task do
    title { Faker::Job.title }
    content { Faker::Lorem.sentences }
    task_begin { Faker::Time.backward(days: 14, period: :evening) }
    task_end { Faker::Time.forward(days: 23, period: :morning) }
    priority { Faker::Number.between(from: 1, to: 3) }
    status { Faker::Number.between(from: 1, to: 3) }
    association :user, factory: :user

    trait :complete do
      status { 3 }
    end
    trait :important do
      priority { 3 }
    end
  end
end
# rubocop:enable Style/AsciiComments
