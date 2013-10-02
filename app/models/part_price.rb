class PartPrice < ActiveRecord::Base
  validates :make, :currency, :presence => true
  validates_presence_of :model, :message => 'Please enter model.'
  validates_presence_of :part_number, :message => 'Please enter part number.'
  validates_uniqueness_of :model, case_sensitive: false , scope: [:make, :part_number, :currency] , :message => '[Make, Model, Part, Currency] combination already exists.'
  validates_uniqueness_of :part_number, case_sensitive: false , scope: [:make, :model, :currency] , :message => '[Make, Model, Part, Currency] combination already exists.'
end
