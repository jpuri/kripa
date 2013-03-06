class AddIdToCustomer < ActiveRecord::Migration
  def self.up
    add_column :customers, :customer_id, :string
  end

  def self.down
    remove_column :customers, :customer_id
  end
end
