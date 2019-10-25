class User 
  include Neo4j::ActiveNode
  property :name, type: String
  property :email, type: String
  property :bodyweight, type: Integer

  has_many :in, :work_units, type: nil
  has_many :in, :work_outs, type: :work_outs

end
