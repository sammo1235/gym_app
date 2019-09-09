class WorkUnit 
  include Neo4j::ActiveNode
  property :weight, type: Integer
  property :reps, type: Integer

  has_one :out, :user, type: nil
  has_one :out, :lift, type: nil # model_class: :Lift


end
