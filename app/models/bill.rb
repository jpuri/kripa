class Bill < ActiveRecord::Base
  has_many :bill_parts
  belongs_to :customer
  belongs_to :currency
end
