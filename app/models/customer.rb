class Customer < ActiveRecord::Base
  validates :customer_id, :name, :presence => true
end
