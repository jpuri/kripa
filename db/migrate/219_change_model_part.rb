class ChangeModelPart < ActiveRecord::Migration 
   def self.up 
    ModelPart.find(13).update_attribute "part_id", 15
    ModelPart.delete_all(:id => 37)
    ModelPart.delete_all(:id => 38)
  end  
end