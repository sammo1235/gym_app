class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :workouts, dependent: :destroy
  has_many :setts, through: :workouts, dependent: :destroy
  has_many :wilks_scores, dependent: :destroy
  has_many :comments
  
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize: "100x100"
    attachable.variant :profile, resize: "250x250"
  end

  scope :ordered_by_wilks, -> { includes(:wilks_scores).order('wilks_scores.score DESC') }

  enum gender: [
    :male,
    :female
  ]

  def self.search(fields)
    bws = fields[:bodyweight].compact.map do |wr| 
      range = wr.split(',').map(&:to_i)
      Range.new(range.min, range.max)
    end
  
    genders = [fields[:male], fields[:female]].compact
    users = filter_users(fields[:username], genders, bws.pop)

    users = bws.inject(users) do |relation, bw_range|
      relation.or(filter_users(fields[:username], genders, bw_range))
    end if bws.any?
    users
  end

  def best_wilks
    wilks_scores.order(score: :desc).first&.score
  end

  def rank
    self.class.ordered_by_wilks.index(self) + 1
  end

  private

  def self.filter_users(username, genders, bodyweight_range)
    where("username LIKE ?", "%#{username}%")
    .where(
      bodyweight: bodyweight_range,
      gender: genders
    )
  end
end
