class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.integer :guest_id
      t.integer :ticket_id
      t.string :gcode
      t.string :status

      t.timestamps
    end
  end
end
