class AddPreviousOverdueToBills < ActiveRecord::Migration
  def self.up
    add_column :bills, :previous_overdue, :float
  end

  def self.down
    remove_column :bills, :previous_overdue
  end
end
