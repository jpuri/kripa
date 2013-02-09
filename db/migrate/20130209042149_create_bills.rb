class CreateBills < ActiveRecord::Migration
  def self.up
    create_table :bills do |t|
      t.date :bill_date
      t.references :customer
      t.references :currency
      t.string :status
      t.float :total_cost

      t.timestamps
    end
  end

  def self.down
    drop_table :bills
  end
end
