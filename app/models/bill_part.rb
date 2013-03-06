class BillPart < ActiveRecord::Base
  belongs_to :bill
  belongs_to :part
end
