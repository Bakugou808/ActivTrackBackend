class CreateCircuitExerciseSessionDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :circuit_exercise_session_details do |t|
      t.references :session, null: false, foreign_key: true
      t.references :circuit_exercise, null: false, foreign_key: true
      t.string :stats

      t.timestamps
    end
  end
end
