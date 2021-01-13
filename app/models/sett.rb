class Sett < ApplicationRecord
  belongs_to :lift
  belongs_to :workout

  # validate presence reps, weight, lift, workout
  def workload
    weight * reps
  end
end
