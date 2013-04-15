class AddModels < ActiveRecord::Migration
  def self.up
    Model.delete_all()
    Model.new(:number => "HV2/219", :make_id => 1).save()
    Model.new(:number => "HV2/220", :make_id => 1).save()
    Model.new(:number => "HV2/270", :make_id => 1).save()
    Model.new(:number => "HL2/160", :make_id => 1).save()
    Model.new(:number => "HV1/140", :make_id => 1).save()
    Model.new(:number => "HV2/200", :make_id => 1).save()
    Model.new(:number => "1A", :make_id => 1).save()
    Model.new(:number => "HL2/90", :make_id => 1).save()
    Model.new(:number => "HL2/77", :make_id => 1).save()
    Model.new(:number => "HL2/120", :make_id => 1).save()
  end
  def self.down
    Model.delete_all()
  end
end