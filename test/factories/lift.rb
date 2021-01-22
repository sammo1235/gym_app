FactoryBot.define do
  factory :lift do
    name {
      %w[
        Back Squat
        Bench Press
        Deadlift
      ].sample
    }
  end
end
