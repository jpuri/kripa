class AddNumberToParts < ActiveRecord::Migration
  def self.up
    add_column :parts, :number, :string
  end

  def self.down
    remove_column :parts, :number
  end
end
