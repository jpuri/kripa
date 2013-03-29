class PartPrice < ActiveRecord::Base
  belongs_to :part
  belongs_to :currency
  belongs_to :customer
  validates :currency, :customer, :price, :presence => true  
  #validates :currency, :uniqueness => { :scope => [:customer, :part],
   # :message => "alresy exists" }
end
