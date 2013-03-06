class RenameModelPriceTopPartPrice < ActiveRecord::Migration
    def self.up
        rename_table :model_prices, :part_prices
    end 
    def self.down
        rename_table :part_prices, :model_prices
    end
 end