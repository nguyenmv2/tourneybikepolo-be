# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    sequence(:name) { |n| "Group #{n}" }
    tournament { nil }
  end
end
