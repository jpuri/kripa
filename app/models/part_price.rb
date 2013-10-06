class PartPrice < ActiveRecord::Base
  validates :make, :currency, :presence => true
  validates :model, :presence => {:message => 'Please enter model.'} 
  validates :part_number, :presence => {:message => 'Please enter part number.'}
  validates :model, :uniqueness => {case_sensitive: false, scope: [:make, :part_number, :currency], :message => '[Make, Model, Part, Currency] combination already exists.'}
end