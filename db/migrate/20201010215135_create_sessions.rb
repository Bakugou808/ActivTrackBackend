class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.references :workout, null: false, foreign_key: true
      t.integer :count
      t.string :active_time
      t.string :rest_time
      t.string :total_time

      t.timestamps
    end
  end
end
