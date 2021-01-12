class Lift < ApplicationRecord
  has_many :setts
  has_many :workouts, through: :setts
end
