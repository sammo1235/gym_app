FactoryBot.define do
  factory :sett do
    weight { rand(1..200) }
    reps { rand(1..20) }
    lift { Lift.first || create(:lift) }
    workout { create :workout }
  end
end
