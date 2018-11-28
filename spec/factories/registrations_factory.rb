# frozen_string_literal: true

FactoryBot.define do
  factory :registration do
    status { "pending" }
    team
    user
    enrollment
  end
end
