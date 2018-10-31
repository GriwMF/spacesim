class Stock < ApplicationRecord
  belongs_to :material
  belongs_to :object, polymorphic: true
end
