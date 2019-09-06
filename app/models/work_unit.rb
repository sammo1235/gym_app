class WorkUnit 
  include Neo4j::ActiveNode
  property :weight, type: Integer
  property :reps, type: Integer

  has_one :out, :user, type: :CREATED, model_class: :User
  has_one :out, :lift, type: :HAS_LIFT


end
