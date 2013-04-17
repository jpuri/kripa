class UpdatePart < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      update parts
      set number = trim(number), description = trim(description)
    SQL
  end
end