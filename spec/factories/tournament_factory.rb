# frozen_string_literal: true

FactoryBot.define do
  factory :tournament do
    name Faker::Esport.event
    start_date 15.days.from_now
    end_date 16.days.from_now
    registration_start_date 2.days.from_now
    registration_end_date 5.days.from_now
    description Faker::Lorem.paragraph
    team_cap Faker::Number.between(6, 30)
    fee Money.new(1500)

    factory :stubbed_tournament_with_teams do
      transient do
        team_count { 4 }
      end

      after(:build) do |tournament, evaluator|
        (0...evaluator.team_count).each do |i|
          tournament.teams << build_stubbed(:team)
        end
      end
    end

    factory :create_tournament_with_teams do
      transient do
        team_count { 4 }
      end

      after(:create) do |tournament, evaluator|
        (0...evaluator.team_count).each do |i|
          tournament.teams << create(:team)
        end
      end
    end
  end
end
