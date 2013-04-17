class AddPartModelPrice < ActiveRecord::Migration
  def self.up
     ModelPart.new(:model_id =>  2 , :part_id =>   34 ).save()
     ModelPart.new(:model_id =>  5 , :part_id =>   34 ).save()
  end
end