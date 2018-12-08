class BayState < ApplicationRecord
  belongs_to :bay, polymorphic: true
end
