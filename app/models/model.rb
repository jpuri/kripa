class Model < ActiveRecord::Base
  has_many :model_parts
  has_many :parts, :through => :model_parts
  validates :name, :number, :presence => true
end
