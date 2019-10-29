class Update 
  include Neo4j::ActiveNode
  property :title, type: String
  property :body, type: String
  property :created_at, type: DateTime

  validates :title, :body, presence: true

end
