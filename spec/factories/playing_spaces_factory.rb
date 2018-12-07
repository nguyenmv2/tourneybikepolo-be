# frozen_string_literal: true

FactoryBot.define do
  factory :playing_space do
    sequence :name do |number|
      "Court #{number}"
    end
  end
end
