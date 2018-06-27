FactoryBot.define do
  factory :roster do
    role Faker::Number.between(1, 3)
    player
    team
  end
end
