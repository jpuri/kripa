class AddWebToCustomers < ActiveRecord::Migration
  def self.up
    add_column :customers, :web, :string
  end

  def self.down
    remove_column :customers, :web
  end
end
