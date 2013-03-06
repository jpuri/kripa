class AddWeightToBillParts < ActiveRecord::Migration
  def self.up
    add_column :bill_parts, :weight, :float
  end

  def self.down
    remove_column :bill_parts, :weight
  end
end
