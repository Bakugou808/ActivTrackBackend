class CreateCircuitExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :circuit_exercises do |t|
      t.references :circuit, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.integer :position
      t.string :attributes

      t.timestamps
    end
  end
end
