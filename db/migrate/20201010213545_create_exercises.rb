class CreateExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :exercises do |t|
      t.string :exercise_name
      t.string :description

      t.timestamps
    end
  end
end
