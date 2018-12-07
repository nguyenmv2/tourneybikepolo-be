# frozen_string_literal: true

FactoryBot.define do
  factory :tournament do
    name { Faker::Esport.event }
    start_date { 15.days.from_now }
    end_date { 16.days.from_now }
    registration_start_date { 2.days.from_now }
    registration_end_date { 5.days.from_now }
    description { Faker::Lorem.paragraph }
    team_cap { Faker::Number.between(6, 30) }
    fee { Money.new(1500) }

    trait :with_playing_spaces do
      transient do
        playing_spaces { 2 }
      end

      after(:stub) do |t, e|
        build_stubbed_list :playing_space, e, tournament: t
      end

      after(:create) do |t, e|
        create_list :playing_space, e, tournament: t
      end
    end
  end
end
