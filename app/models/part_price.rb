class PartPrice < ActiveRecord::Base
  belongs_to :part
  belongs_to :currency
  belongs_to :customer
end