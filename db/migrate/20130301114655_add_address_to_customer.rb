class AddAddressToCustomer < ActiveRecord::Migration
  def self.up
    add_column :customers, :address, :string
  end

  def self.down
    remove_column :customers, :address
  end
end
