class AddFaxToCustomers < ActiveRecord::Migration
  def self.up
    add_column :customers, :fax, :string
  end

  def self.down
    remove_column :customers, :fax
  end
end
