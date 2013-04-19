class Model < ActiveRecord::Base
  belongs_to :make
  has_many :model_parts
  has_many :parts, :through => :model_parts
  validates :number, :presence => true
end
