class CreateWorkouts < ActiveRecord::Migration[6.0]
  def change
    create_table :workouts do |t|
      t.references :folder, null: false, foreign_key: true
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
