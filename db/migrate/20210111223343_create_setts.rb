class CreateSetts < ActiveRecord::Migration[6.0]
  def change
    create_table :setts do |t|
      t.integer :reps, null: false
      t.integer :weight, null: false
      t.references :lift, null: false, foreign_key: true
      t.references :workout, null: false, foreign_key: true

      t.timestamps
    end
  end
end
