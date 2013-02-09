class CreateBillParts < ActiveRecord::Migration
  def self.up
    create_table :bill_parts do |t|
      t.references :model_price
      t.references :bill
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :bill_parts
  end
end
