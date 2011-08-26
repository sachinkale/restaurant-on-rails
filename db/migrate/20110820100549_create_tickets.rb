class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :r_table_id
      t.integer :guest_id
      t.string :status
      t.integer :waiter_id

      t.timestamps
    end
  end
end
