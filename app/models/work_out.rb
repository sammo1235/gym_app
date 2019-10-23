class WorkOut 
  include Neo4j::ActiveNode
  property :type, type: String
  property :created_at, type: DateTime
  property :total_workload, type: Integer
  property :total_sets, type: Integer

  has_one :in, :user, type: nil
  has_many :in, :work_unit, type: nil

  before_save :calculate_total_sets

  def calculate_total_sets
    self.total_sets = self.work_unit.count
  end
end
