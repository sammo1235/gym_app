class CreateWorkUnit < Neo4j::Migrations::Base
  def up
    add_constraint :WorkUnit, :uuid
  end

  def down
    drop_constraint :WorkUnit, :uuid
  end
end
