class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :code
      t.integer :category_id
      t.integer :sell_price
      t.string :image
      t.text :attribute

      t.timestamps
    end
  end
end
