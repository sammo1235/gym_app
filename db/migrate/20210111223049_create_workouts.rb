class CreateWorkouts < ActiveRecord::Migration[6.0]
  def change
    create_table :workouts do |t|
      t.integer :variant
      t.string :notes

      t.timestamps
    end
  end
end
