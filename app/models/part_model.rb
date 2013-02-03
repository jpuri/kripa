class PartModel < ActiveRecord::Base
  has_many :model_prices
  belongs_to :part
end
