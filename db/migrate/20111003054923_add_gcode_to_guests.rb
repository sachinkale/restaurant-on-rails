class AddGcodeToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :gcode, :string
  end
end
