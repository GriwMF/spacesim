class History < ApplicationRecord
  belongs_to :object
  belongs_to :target
end
