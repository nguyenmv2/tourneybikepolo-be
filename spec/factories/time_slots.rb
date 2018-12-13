# frozen_string_literal: true

FactoryBot.define do
  factory :time_slot do
    time { "2018-12-13 13:50:37" }
    tournament { nil }
  end
end
