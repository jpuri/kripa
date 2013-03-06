class AddPartToBillParts < ActiveRecord::Migration
  def self.up
    add_column :bill_parts, :part_id, :int
  end

  def self.down
    remove_column :bill_parts, :part_id
  end
end
