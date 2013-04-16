class AddModelParts < ActiveRecord::Migration
  def self.up
    ModelPart.delete_all()
     ModelPart.new(:model_id =>  2 , :part_id =>   6 ).save()
     ModelPart.new(:model_id =>  2 , :part_id =>   7 ).save()
     ModelPart.new(:model_id =>  3 , :part_id =>   8 ).save()
     ModelPart.new(:model_id =>  3 , :part_id =>   9 ).save()
     ModelPart.new(:model_id =>  4 , :part_id =>   10  ).save()
     ModelPart.new(:model_id =>  4 , :part_id =>   11  ).save()
     ModelPart.new(:model_id =>  5 , :part_id =>   12  ).save()
     ModelPart.new(:model_id =>  6 , :part_id =>   13  ).save()
     ModelPart.new(:model_id =>  5 , :part_id =>   14  ).save()
     ModelPart.new(:model_id =>  5 , :part_id =>   14  ).save()
     ModelPart.new(:model_id =>  7 , :part_id =>   19  ).save()
     ModelPart.new(:model_id =>  7 , :part_id =>   20  ).save()
     ModelPart.new(:model_id =>  4 , :part_id =>   21  ).save()
     ModelPart.new(:model_id =>  2 , :part_id =>   22  ).save()
     ModelPart.new(:model_id =>  8 , :part_id =>   23  ).save()
     ModelPart.new(:model_id =>  2 , :part_id =>   18  ).save()
     ModelPart.new(:model_id =>  2 , :part_id =>   17  ).save()
     ModelPart.new(:model_id =>  9 , :part_id =>   3 ).save()
     ModelPart.new(:model_id =>  2 , :part_id =>   16  ).save()
     ModelPart.new(:model_id =>  2 , :part_id =>   5 ).save()
     ModelPart.new(:model_id =>  9 , :part_id =>   32  ).save()
     ModelPart.new(:model_id =>  9 , :part_id =>   33  ).save()
     ModelPart.new(:model_id =>  9 , :part_id =>   27  ).save()
     ModelPart.new(:model_id =>  9 , :part_id =>   29  ).save()
     ModelPart.new(:model_id =>  9 , :part_id =>   28  ).save()
     ModelPart.new(:model_id =>  5 , :part_id =>   4 ).save()
     ModelPart.new(:model_id =>  5 , :part_id =>   31  ).save()
     ModelPart.new(:model_id =>  5 , :part_id =>   30  ).save()
     ModelPart.new(:model_id =>  5 , :part_id =>   26  ).save()
     ModelPart.new(:model_id =>  5 , :part_id =>   33  ).save()
     ModelPart.new(:model_id =>  5 , :part_id =>   32  ).save()
     ModelPart.new(:model_id =>  10  , :part_id =>   33  ).save()
     ModelPart.new(:model_id =>  10  , :part_id =>   32  ).save()
     ModelPart.new(:model_id =>  9 , :part_id =>   33  ).save()
     ModelPart.new(:model_id =>  9 , :part_id =>   32  ).save()
     ModelPart.new(:model_id =>  10  , :part_id =>   27  ).save()
     ModelPart.new(:model_id =>  11  , :part_id =>   33  ).save()
     ModelPart.new(:model_id =>  11  , :part_id =>   32  ).save()
     ModelPart.new(:model_id =>  11  , :part_id =>   27  ).save()
     ModelPart.new(:model_id =>  5 , :part_id =>   27  ).save()
     ModelPart.new(:model_id =>  5 , :part_id =>   25  ).save()
     ModelPart.new(:model_id =>  5 , :part_id =>   24  ).save()
  end
  def self.down
    ModelPart.delete_all()
  end
end