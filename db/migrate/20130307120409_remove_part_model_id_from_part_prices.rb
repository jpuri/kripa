class RemovePartModelIdFromPartPrices < ActiveRecord::Migration
  def self.up
    remove_column :part_prices, :part_model_id
  end

  def self.down
    add_column :part_prices, :part_model_id, :int
  end
end
