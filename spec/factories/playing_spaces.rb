# frozen_string_literal: true

FactoryBot.define do
  factory :playing_space do
    sequence(:name) { |n| "Court #{n}" }
    tournament { nil }
  end
end
