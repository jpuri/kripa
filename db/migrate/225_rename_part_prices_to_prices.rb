class RenamePartPricesToPrices < ActiveRecord::Migration
    def self.up
        rename_table :part_prices, :prices
    end 
    def self.down
        rename_table :prices, :part_prices
    end
 end