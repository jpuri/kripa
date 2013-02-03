class InsertModelPrices < ActiveRecord::Migration
  def self.up
    ModelPrice.new(:part_model_id => 1, :currency_id => 1, :price => 10).save(false)
    ModelPrice.new(:part_model_id => 1, :currency_id => 2, :price => 15).save(false)
    ModelPrice.new(:part_model_id => 2, :currency_id => 1, :price => 20).save(false)
    ModelPrice.new(:part_model_id => 2, :currency_id => 2, :price => 25).save(false)
    ModelPrice.new(:part_model_id => 3, :currency_id => 1, :price => 30).save(false)
    ModelPrice.new(:part_model_id => 3, :currency_id => 2, :price => 35).save(false)
    ModelPrice.new(:part_model_id => 4, :currency_id => 1, :price => 40).save(false)
    ModelPrice.new(:part_model_id => 4, :currency_id => 2, :price => 45).save(false)
  end
  def self.down
    ModelPrice.delete_all(:part_model_id => 1)
    ModelPrice.delete_all(:part_model_id => 2)
    ModelPrice.delete_all(:part_model_id => 3)
    ModelPrice.delete_all(:part_model_id => 4)
  end
end