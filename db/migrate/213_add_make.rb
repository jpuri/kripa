class AddMake < ActiveRecord::Migration
  def self.up
    Make.new(:id => 1, :name => "SPERRE").save()
  end
  def self.down
    Model.delete_all(:id => 1)
  end
end