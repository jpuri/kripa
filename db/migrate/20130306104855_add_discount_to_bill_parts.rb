class AddDiscountToBillParts < ActiveRecord::Migration
  def self.up
    add_column :bill_parts, :discount, :float
  end

  def self.down
    remove_column :bill_parts, :discount
  end
end
