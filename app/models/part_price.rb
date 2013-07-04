class PartPrice < ActiveRecord::Base
  validates :make, :model, :part_number, :currency, :presence => true
end
