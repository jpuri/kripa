class InsertPartsModels < ActiveRecord::Migration
  def self.up
    PartModel.new(:model_name => "Part1Model1", :part_id => 1).save(false)
    PartModel.new(:model_name => "Part1Model2", :part_id => 1).save(false)
    PartModel.new(:model_name => "Part2Model1", :part_id => 2).save(false)
    PartModel.new(:model_name => "Part2Model2", :part_id => 2).save(false)
  end
  def self.down
    PartModel.delete_all(:model_name => "Part1Model1")
    PartModel.delete_all(:model_name => "Part1Model2")
    PartModel.delete_all(:model_name => "Part2Model1")
    PartModel.delete_all(:model_name => "Part2Model2")
  end
end