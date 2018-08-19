# frozen_string_literal: true

FactoryBot.define do
  factory :match do
    team_one_score Faker::Number.between(0, 5)
    team_two_score Faker::Number.between(0, 5)
    association :team_one, factory: :team
    association :team_two, factory: :team
    tournament
  end
end
