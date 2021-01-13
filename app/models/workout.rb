class Workout < ApplicationRecord
  belongs_to :user
  has_many :setts
  has_many :lifts, through: :setts
  accepts_nested_attributes_for :setts, allow_destroy: true

  enum variant: [
    :back,
    :legs,
    :chest,
    :upper,
    :lower,
    :full_body,
    :shoulders
  ]

  def total_workload
    setts.reduce(0) {|memo, sett| memo += sett.workload; memo }
  end

  def prepared_variant
    variant.capitalize.gsub(/_/, ' ')
  end
end
