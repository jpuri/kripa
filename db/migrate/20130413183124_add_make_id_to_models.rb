class AddMakeIdToModels < ActiveRecord::Migration
  def self.up
    add_column :models, :make_id, :integer
  end

  def self.down
    remove_column :models, :make_id
  end
end
