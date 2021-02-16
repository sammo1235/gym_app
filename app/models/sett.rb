class Sett < ApplicationRecord
  belongs_to :lift
  belongs_to :workout

  validates :reps, :weight, :lift, presence: :true

  after_update -> { WilksScore.create_score(self.workout, self.workout.user) }

  def self.user_history(user)
    lift_ids = Lift.where(name: Lift::POWERLIFTS.keys).pluck(:id)

    history = (user.created_at.to_date..Date.today).each_with_object(Hash.new(0)) do |date, hash| 
      hash[date.strftime("%d/%m")] = [0, 0, 0]
    end

    user.setts.where(lift_id: lift_ids).map do |sett|
      history[sett.created_at.strftime("%d/%m")][Lift::POWERLIFTS[sett.lift.name]] = sett.workload
    end
    
    history.to_a.map(&:flatten)
  end

  def workload
    weight * reps
  end

  def self.user_best_for_lift(user, lift)
    unless lift.is_a? Lift
      lift = Lift.find_by(name: lift)
      if lift.nil?
        raise ActiveRecord::RecordNotFound
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
    end
  end

  def upper_body_projected_1RM
    (weight.round * 1.1307 + 0.6998).round(2)
  end

  def lower_body_projected_1RM
    (weight.round * 1.09703 + 14.2546).round(2)
  end
end
