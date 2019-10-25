class WorkUnit 
  include Neo4j::ActiveNode
  property :weight, type: Integer
  property :reps, type: Integer
  property :workload, type: Integer
  property :created_at, type: DateTime

  has_one :out, :user, type: nil
  has_one :out, :lift, type: nil
  has_one :out, :work_out, type: nil

  before_save :workout_prescence
  validate :user_match_workout
  validate :lift_prescence

  def workout_prescence
    #errors.add(:work_out, "Work Unit must have an associated workout") unless
    #work_out.present?
  end

  def lift_prescence
    errors.add(:lift, "Set must had an associated lift") unless
    lift.present?
  end

  def user_match_workout
    errors.add(:users, "Unit user must match workout") unless
    self.user.id == self.work_out.user.id
  end

  before_create :calc_workload
  before_update :calc_workload

  def calc_workload
    self.workload = weight * reps
  end
end
