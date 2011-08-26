class CreateTicketLines < ActiveRecord::Migration
  def change
    create_table :ticket_lines do |t|
      t.integer :ticket_id
      t.integer :product_id
      t.float :sell_price
      t.integer :qty

      t.timestamps
    end
  end
end
