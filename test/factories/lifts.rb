FactoryBot.define do
  factory :lift do
    name {
      %w[
        Squat
        Bench
        Deadlift
        Row
        Incline Dumbell Press
        Romainian Deadlift
        Dumbell Press
        Dumbell Row
        Machine OHP
        Lat Pulldown
        Pullups
        Leg Press
        Dips
      ].sample
    }
  end
end
