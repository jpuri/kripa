class AddDueDateToBills < ActiveRecord::Migration
  def self.up
    add_column :bills, :due_date, :date
  end

  def self.down
    remove_column :bills, :due_date
  end
end
