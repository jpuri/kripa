class BillPart < ActiveRecord::Base
  belongs_to :model_price
  belongs_to :bill
end
