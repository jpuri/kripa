class AddDescriptionToParts < ActiveRecord::Migration
  def self.up
    add_column :parts, :description, :string
  end

  def self.down
    remove_column :parts, :description
  end
end
