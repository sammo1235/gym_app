class CreateUpdate < Neo4j::Migrations::Base
  def up
    add_constraint :Update, :uuid
  end

  def down
    drop_constraint :Update, :uuid
  end
end
