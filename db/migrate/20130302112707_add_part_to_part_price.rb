class AddPartToPartPrice < ActiveRecord::Migration
  def self.up
    add_column :part_prices, :part_id, :int
  end

  def self.down
    remove_column :part_prices, :part_id
  end
end
