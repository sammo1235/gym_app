class Lift < ApplicationRecord
  has_many :setts
  has_many :workouts, through: :setts

  POWERLIFTS = {'Back Squat' => 0, 'Bench Press' => 1, 'Deadlift' => 2}
end
