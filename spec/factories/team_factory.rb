# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    name Faker::Team.name
    description Faker::Lorem.paragraph
    logo Faker::Avatar.image
    player_count Faker::Number.between(1, 6)
  end
end
