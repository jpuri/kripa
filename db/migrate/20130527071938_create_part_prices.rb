class CreatePartPrices < ActiveRecord::Migration
  def self.up
    create_table :part_prices do |t|
      t.string :make
      t.string :model
      t.string :part_number
      t.string :part_desc
      t.float :weight
      t.string :currency
      t.float :price

      t.timestamps
    end
  end

  def self.down
    drop_table :part_prices
  end
end
