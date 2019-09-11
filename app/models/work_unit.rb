class WorkUnit 
  include Neo4j::ActiveNode
  property :weight, type: Integer
  property :reps, type: Integer
  property :workload, type: Integer
  property :created_at, type: DateTime

  has_one :out, :user, type: nil
  has_one :out, :lift, type: nil
  has_one :out, :work_out, type: nil

  before_create do
    self.workload = weight * reps
  end
end
