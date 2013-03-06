class CreateModelParts < ActiveRecord::Migration
  def self.up
    create_table :model_parts do |t|
      t.references :model
      t.references :part

      t.timestamps
    end
  end

  def self.down
    drop_table :model_parts
  end
end
