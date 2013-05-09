class Part < ActiveRecord::Base
  has_many :bill_parts
  has_many :prices
  has_many :model_parts
  has_many :models, :through => :model_parts
  validates :number, :presence => true
end
