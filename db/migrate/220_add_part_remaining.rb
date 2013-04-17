class AddPartRemaining < ActiveRecord::Migration
  def self.up
      Part.new(:number => "3700", :description => "VENTILATOR", :weight => 2 ).save()
  end
end