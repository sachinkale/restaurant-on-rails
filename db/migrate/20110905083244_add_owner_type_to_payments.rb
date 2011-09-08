class AddOwnerTypeToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :owner_type, :string
  end
end
