class AddUser < ActiveRecord::Migration
  def self.up
    User.new(
      :id => 1, 
      :password_hash => "$2a$10$Y45mIDr4cenB4k4ViU5uMutAalro0XON.llRS5LzwxLHytdJ.IHcy",
      :password_salt => "$2a$10$Y45mIDr4cenB4k4ViU5uMu",
      :created_at => Date.new(),
      :updated_at => Date.new(),
      :role => "admin",
      :username => "marine-admin"
    ).save()
  end
  def self.down
    User.delete(:id => 1)
  end
end