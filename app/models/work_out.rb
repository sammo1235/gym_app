class WorkOut 
  include Neo4j::ActiveNode
  property :type, type: String
  property :created_at, type: DateTime
  property :total_workload, type: Integer
  property :total_sets, type: Integer

  has_one :out, :user, type: nil
  has_many :in, :work_unit, type: nil

  before_save :work_units_presence
  validates :type, presence: true
  validate :user_prescence

  def work_units_presence
    errors.add(:work_units, "You must add at least one set to the workout") unless
    work_unit.present?
  end

  def user_prescence
    errors.add(:user, "Workout must have an associated user") unless
    user.present?
  end

  before_save do
    self.total_sets = self.work_unit.count
  end
  
  def calculate_workout_volume
    load = 0
    self.work_unit.each { |wu| load += wu.workload }
    self.total_workload = load
    self.save
  end
end
