# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:player] do
    first { Faker::Name.first_name }
    last { Faker::Name.last_name }
    sequence(:email) do |_n|
      Faker::Internet.safe_email
    end
    password { Faker::Internet.password(8) }
  end
end
