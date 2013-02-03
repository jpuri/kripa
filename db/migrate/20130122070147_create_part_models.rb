class CreatePartModels < ActiveRecord::Migration
  def self.up
    create_table :part_models do |t|
      t.string :model_name
      t.references :part

      t.timestamps
    end
  end

  def self.down
    drop_table :part_models
  end
end
