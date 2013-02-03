class InsertCurrencies < ActiveRecord::Migration
  def self.up
    Currency.new(:name => "Dollar", :symbol => "$").save()
    Currency.new(:name => "Rupees", :symbol => "Rs").save()
  end
  def self.down
    Currency.delete_all(:name => "Dollar")
    Currency.delete_all(:name => "Rupees")
  end
end