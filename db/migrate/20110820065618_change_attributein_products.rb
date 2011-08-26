class ChangeAttributeinProducts < ActiveRecord::Migration
  def up
    rename_column :products, :attribute, :pattribute
  end

  def down
  end
end
