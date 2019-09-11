class ForceCreateWorkOutUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :WorkOut, :uuid, force: true
  end

  def down
    drop_constraint :WorkOut, :uuid
  end
end
