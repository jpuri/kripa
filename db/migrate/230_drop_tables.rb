class DropTables < ActiveRecord::Migration
  def self.up
    drop_table :makes
    drop_table :model_parts
    drop_table :prices
    drop_table :bill_parts
    drop_table :bills
    drop_table :currencies
    drop_table :customers
    drop_table :models
    drop_table :part_models
    drop_table :parts
  end
end
