class AddPartLeft < ActiveRecord::Migration
  def self.up
      Part.new(:number => "3710", :description => "VENTILATOR", :weight => 2 ).save()
  end
end