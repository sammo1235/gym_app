class CreateWilksScores < ActiveRecord::Migration[6.0]
  def change
    create_table :wilks_scores do |t|
      t.float :score
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
