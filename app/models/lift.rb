class Lift < ApplicationRecord
  has_many :setts
  has_many :workouts, through: :setts

  POWERLIFTS = {'Back Squat' => 0, 'Bench Press' => 1, 'Deadlift' => 2}

  def self.powerlift_ids
    where(name: Lift::POWERLIFTS.keys).pluck(:id)
  end
end
