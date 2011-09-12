class CreateClosedCashes < ActiveRecord::Migration
  def change
    create_table :closed_cashes do |t|
      t.integer :ticket_id

      t.timestamps
    end
  end
end
