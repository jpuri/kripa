class UpdateColorDefaultToPartPrices < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      update part_prices
      set color = '#FFFFFF'
    SQL
  end
end
