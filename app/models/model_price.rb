class ModelPrice < ActiveRecord::Base
  belongs_to :part_model
  belongs_to :currency
end
