class InsertParts < ActiveRecord::Migration
  def self.up
    Part.new(:name => "Part1", :weight => "10").save()
    Part.new(:name => "Part2", :weight => "20").save()
  end
  def self.down
    Part.delete_all(:name => "Part1")
    Part.delete_all(:name => "Part2")
  end
end