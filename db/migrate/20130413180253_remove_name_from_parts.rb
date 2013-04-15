class RemoveNameFromParts < ActiveRecord::Migration
  def self.up
    remove_column :parts, :name
  end

  def self.down
    add_column :parts, :name, :string
  end
end
