class AddPartModelNew < ActiveRecord::Migration
  def self.up
    PartPrice.new(:currency_id =>   2 , :part_id =>   34 , :price =>   32  , :customer_id =>   1 ).save()
    PartPrice.new(:currency_id =>   2 , :part_id =>   34 , :price =>   32  , :customer_id =>   2 ).save()
  end
end