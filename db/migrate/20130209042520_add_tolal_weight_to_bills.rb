class AddTolalWeightToBills < ActiveRecord::Migration
  def self.up
    add_column :bills, :total_weight, :float
  end

  def self.down
    remove_column :bills, :total_weight
  end
end
