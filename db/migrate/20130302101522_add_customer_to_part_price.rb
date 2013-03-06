class AddCustomerToPartPrice < ActiveRecord::Migration
  def self.up
    add_column :part_prices, :customer_id, :int
  end

  def self.down
    remove_column :part_prices, :customer_id
  end
end
