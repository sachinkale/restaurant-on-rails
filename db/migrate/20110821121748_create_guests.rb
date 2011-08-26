class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :FirstName
      t.string :LastName
      t.integer :age
      t.string :photo
      t.text :address
      t.string :phone
      t.string :email
      t.date :bbirthdate

      t.timestamps
    end
  end
end
