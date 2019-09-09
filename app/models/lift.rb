class Lift 
  include Neo4j::ActiveNode
  property :name, type: String


  has_many :in, :work_units, type: nil
end
