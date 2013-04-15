class RemoveNameFromModels < ActiveRecord::Migration
  def self.up
    remove_column :models, :name
  end

  def self.down
    add_column :models, :name, :string
  end
end
