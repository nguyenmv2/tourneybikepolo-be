# frozen_string_literal: true

FactoryBot.define do
  factory :timer do
    duration 1
    paused_with "2018-07-20 15:35:23"
    expires_at "2018-07-20 15:35:23"
  end
end
