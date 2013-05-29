class PartPrice < ActiveRecord::Base
  validates :make, :model, :part_number, :currency, :price, :presence => true
end
