class WilksScore < ApplicationRecord
  belongs_to :user
  # do we want to access the setts used to create the wilks_score?
  # maybe wilks.setts > through join table wilks_score_setts ?

  def self.user_history(user)
    history = (user.created_at.to_date..Date.today).each_with_object(Hash.new(0)) do |date, hash| 
      hash[date.strftime("%d/%m")] = 0
    end

    WilksScore.where(user: user).map do |wilks|
      history[wilks.created_at.strftime("%d/%m")] = wilks.score
    end

    history.to_a
  end

  def self.create_score(workout, user)
    lift_ids = Lift.where(name: Lift::POWERLIFTS.keys).pluck(:id)

    personal_bests = Hash[Lift::POWERLIFTS.keys.map {|lift| [lift, Sett.user_best_for_lift(user, lift)]}]

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
