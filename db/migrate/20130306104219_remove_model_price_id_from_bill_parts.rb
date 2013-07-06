class RemoveEmailFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :email, :user_id
  end

  def self.down
    add_column :email, :users
  end
end
