class UpdateCurrency < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      update currencies
      set name = 'GBP' where name = 'Sterling'
    SQL
  end
end