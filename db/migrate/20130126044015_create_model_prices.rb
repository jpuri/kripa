class CreateModelPrices < ActiveRecord::Migration
  def self.up
    create_table :model_prices do |t|
      t.references :part_model
      t.references :currency
      t.float :price

      t.timestamps
    end
  end

  def self.down
    drop_table :model_prices
  end
end

