class Sett < ApplicationRecord
  belongs_to :lift
  belongs_to :workout

  # validate presence reps, weight, lift, workout
  def workload
    weight * reps
  end

  private
  def sett_params
    params.require(:sett).permit(:weight, :reps, :lift_id)
  end
end
