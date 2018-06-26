FactoryBot.define do
  factory :user do
    first "Test"
    last "User"
    sequence(:email) do |n|
      "person_#{Faker::Lorem.word.downcase}_#{n}@example.com"
    end
    password "Taco123"
  end
end
