class WilksScore < ApplicationRecord
  belongs_to :user
  # do we want to access the setts used to create the wilks_score?
  # maybe wilks.setts > through join table wilks_score_setts ?

  LIFTS = ['Back Squat', 'Bench Press', 'Deadlift']

  def self.create_score(workout, user)
    lift_ids = Lift.where(name: LIFTS).pluck(:id)

    personal_bests = Hash[LIFTS.map {|lift| [lift, Sett.user_best_for_lift(user, lift)]}]

    workout.setts.where(lift_id: lift_ids, reps: [1, (4..6)]).each do |sett|
      one_rep_max = sett.one_rep_max

      if personal_bests[sett.lift.name] < one_rep_max
        personal_bests[sett.lift.name] = one_rep_max
      end
    end

    return unless personal_bests.values.select(&:zero?).size.zero?

    new_wilks = WilksCalc.send(user.gender, user.bodyweight, personal_bests.values.sum)

    if user.best_wilks.nil? || new_wilks > user.best_wilks
      self.create(user: user, score: new_wilks)
    end
  end
end
