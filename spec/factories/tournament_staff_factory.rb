# frozen_string_literal: true

FactoryBot.define do
  factory :tournament_staff do
    role Faker::Number.between(1, 3)
    user
    tournament
  end
end
