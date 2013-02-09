class Bill < ActiveRecord::Base
  belongs_to :customer
  belongs_to :currency
end
