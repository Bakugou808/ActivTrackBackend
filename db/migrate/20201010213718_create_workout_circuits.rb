class CreateWorkoutCircuits < ActiveRecord::Migration[6.0]
  def change
    create_table :workout_circuits do |t|
      t.references :workout, null: false, foreign_key: true
      t.references :circuit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
