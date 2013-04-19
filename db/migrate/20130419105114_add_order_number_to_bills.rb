class AddOrderNumberToBills < ActiveRecord::Migration
  def self.up
    add_column :bills, :order_number, :string
  end

  def self.down
    remove_column :bills, :order_number
  end
end
