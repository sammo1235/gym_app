class Workout < ApplicationRecord
  belongs_to :user
  has_many :setts, dependent: :destroy
  has_many :lifts, through: :setts
  accepts_nested_attributes_for :setts, allow_destroy: true

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
    user.workouts.map do |workout|
      [
        workout.created_at.strftime("%d/%m"),
        workout.total_workload
      ]
    end
  end

  def total_workload
    setts.reduce(0) {|memo, sett| memo += sett.workload; memo }
  end

  def prepared_variant
    variant.capitalize.gsub(/_/, ' ')
  end
end
