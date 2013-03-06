class ModelPart < ActiveRecord::Base
  belongs_to :model
  belongs_to :part
end
