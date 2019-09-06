class CreateLift < Neo4j::Migrations::Base
  def up
    add_constraint :Lift, :uuid
  end

  def down
    drop_constraint :Lift, :uuid
  end
end
