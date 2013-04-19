class AddFlightNumberToBills < ActiveRecord::Migration
  def self.up
    add_column :bills, :flight_number, :string
  end

  def self.down
    remove_column :bills, :flight_number
  end
end
