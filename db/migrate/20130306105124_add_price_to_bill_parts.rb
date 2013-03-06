class AddPriceToBillParts < ActiveRecord::Migration
  def self.up
    add_column :bill_parts, :price, :float
  end

  def self.down
    remove_column :bill_parts, :price
  end
end
