# frozen_string_literal: true

FactoryBot.define do
  factory :registration do
    status Faker::Number.between(1, 3)
    team
    user
    enrollment
  end
end
