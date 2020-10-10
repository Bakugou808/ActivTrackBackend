class CreateCircuits < ActiveRecord::Migration[6.0]
  def change
    create_table :circuits do |t|
      t.string :phase
      t.integer :position
      t.string :type

      t.timestamps
    end
  end
end
