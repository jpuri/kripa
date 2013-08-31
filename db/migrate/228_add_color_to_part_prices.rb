class AddColorToPartPrices < ActiveRecord::Migration
  def self.up
    add_column :part_prices, :color, :string, :default => '#FFFFFF'
  end

  def self.down
    remove_column :part_prices, :color
  end
end
