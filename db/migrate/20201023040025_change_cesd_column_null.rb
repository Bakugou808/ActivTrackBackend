class ChangeCesdColumnNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:circuit_exercise_session_details, :circuit_exercise_id, true)
  end
end
