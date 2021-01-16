FactoryBot.define do
  factory :workout do
    variant { rand(1..Workout.variants.size-1) }
    notes { Faker::Lorem.sentence }
    user { create(:user) }
  end
end
