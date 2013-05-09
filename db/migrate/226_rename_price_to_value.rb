class RenamePriceToValue < ActiveRecord::Migration
  def self.up
    rename_column :prices, :price, :value
  end

  def self.down
    rename_column :prices, :value, :price
  end
end
