class AddNumberToModels < ActiveRecord::Migration
  def self.up
    add_column :models, :number, :string
  end

  def self.down
    remove_column :models, :number
  end
end
