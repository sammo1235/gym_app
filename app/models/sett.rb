class Sett < ApplicationRecord
  belongs_to :lift
  belongs_to :workout

  # validate presence reps, weight, lift, workout
  def workload
    weight * reps
  end

  def self.user_best_for_lift(user, lift)
    unless lift.is_a? Lift
      begin
        lift = Lift.find_by(name: lift)
      rescue ActiveRecord::RecordNotFound => e
        print e
      end
    end

    best = 0

    user.setts.where(lift: lift, reps: [1, (4..6)]).each do |sett|
      weight = sett.one_rep_max
      best = weight if weight > best
    end

    best
  end

  def one_rep_max
    if reps == 1
      weight
    elsif reps.between?(4, 6)
      if lift.name == 'Bench Press'
        upper_body_projected_1RM
      else
        lower_body_projected_1RM
      end
    else
      0
      # raise StandardError::MaxCannotBeCalculatedError => e
    end
  end

  def upper_body_projected_1RM
    (weight.round * 1.1307 + 0.6998).round(2)
  end

  def lower_body_projected_1RM
    (weight.round * 1.09703 + 14.2546).round(2)
  end
end
