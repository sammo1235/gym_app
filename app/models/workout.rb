class Workout < ApplicationRecord
  belongs_to :user
  has_many :setts, dependent: :destroy
  has_many :lifts, through: :setts
  has_many :comments
  accepts_nested_attributes_for :setts, allow_destroy: true

  after_create_commit { broadcast_prepend_to "workouts" }
  after_destroy_commit { broadcast_remove_to "workouts" }

  after_save -> { WilksScore.create_score(self, self.user) }

  enum variant: [
    :back,
    :legs,
    :chest,
    :upper,
    :lower,
    :full_body,
    :shoulders
  ]

  def self.user_history(user)
    past_month = (user.created_at.to_date..Date.today).each_with_object(Hash.new(0)) do |date, hash| 
      hash[date.strftime("%d/%m")] = Workout.variants.map {|k, v| [k, 0]}.to_h
    end

    Workout.where(user: user, variant: [0, 1, 2, 3, 4]).map do |workout|
      past_month[workout.created_at.strftime("%d/%m")][workout.variant] += workout.total_workload
    end

    past_month.map {|k, v| [k,v.values]}.map(&:flatten)
  end

  def total_workload
    setts.reduce(0) {|memo, sett| memo += sett.workload; memo }
  end

  def prepared_variant
    variant.capitalize.gsub(/_/, ' ')
  end
end
