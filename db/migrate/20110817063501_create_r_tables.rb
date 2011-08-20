class CreateRTables < ActiveRecord::Migration
  def change
    create_table :r_tables do |t|
      t.integer :floor_id
      t.integer :x_position
      t.integer :y_position
      t.string :name

      t.timestamps
    end
  end
end
