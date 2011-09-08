class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :owner
      t.integer :owner_id
      t.integer :payment_method_id
      t.float :amount

      t.timestamps
    end
  end
end
