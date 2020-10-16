class CreateCircuitExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :circuit_exercises do |t|
      t.references :circuit, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.integer :position
      t.json :ex_attributes
      
      t.timestamps
    end
  end
end
# * IF YA WANNA STORE A DAMN OBJECT USE .JSON AS YOUR DATA TYPE SON...
# * IF YA WANNA STORE AN ARRAY, USE .TEXT AS A DATA TYPE AND SET, ARRAY: TRUE
