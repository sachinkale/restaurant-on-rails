class ChangeGcodeInDiscounts < ActiveRecord::Migration
  def up
    rename_column :discounts, :gcode,:dcode
  end

  def down
  end
end
