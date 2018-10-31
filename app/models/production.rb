class Production < ApplicationRecord
  belongs_to :material
  belongs_to :factory
end
