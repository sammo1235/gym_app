class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :workouts, dependent: :destroy
  has_many :setts, through: :workouts, dependent: :destroy
  has_many :wilks_scores, dependent: :destroy

  scope :ordered_by_wilks, -> { includes(:wilks_scores).order('wilks_scores.score DESC') }

  enum gender: [
    :male,
    :female
  ]

  def best_wilks
    wilks_scores.order(score: :desc).first&.score || "N/A"
  end
end
