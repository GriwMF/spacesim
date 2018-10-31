class Material < ApplicationRecord
  has_many :stocks
  has_many :productions
end
