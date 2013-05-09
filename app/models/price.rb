class Price < ActiveRecord::Base
  belongs_to :part
  belongs_to :currency
  belongs_to :customer
  validates :currency, :customer, :value, :presence => true  
end
