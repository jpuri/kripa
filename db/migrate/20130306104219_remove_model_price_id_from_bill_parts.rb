class RemoveModelPriceIdFromBillParts < ActiveRecord::Migration
  def self.up
    remove_column :bill_parts, :model_price_id
  end

  def self.down
    add_column :bill_parts, :model_price_id, :BillParts
  end
end
