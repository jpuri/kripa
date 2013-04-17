class AddPartOther < ActiveRecord::Migration
  def self.up
    PartPrice.new(:currency_id => 2, :part_id => 14, :price => 383, :customer_id => 1).save()
    PartPrice.new(:currency_id => 2, :part_id => 15, :price => 125.7, :customer_id => 1).save()
    PartPrice.new(:currency_id => 2, :part_id => 14, :price => 383, :customer_id => 2).save()
    PartPrice.new(:currency_id => 2, :part_id => 15, :price => 125.7, :customer_id => 2).save()
    PartPrice.delete_all(:id => 46)
    PartPrice.delete_all(:id => 47)
    PartPrice.delete_all(:id => 77)
    PartPrice.delete_all(:id => 78)
  end
  def self.down
    PartPrice.delete_all()
  end
end