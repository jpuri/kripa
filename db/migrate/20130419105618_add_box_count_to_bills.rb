class AddBoxCountToBills < ActiveRecord::Migration
  def self.up
    add_column :bills, :box_count, :integer
  end

  def self.down
    remove_column :bills, :box_count
  end
end
