class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :workouts, dependent: :destroy
  has_many :setts, through: :workouts, dependent: :destroy

  enum gender: [
    :male,
    :female
  ]
end
