class Ship < ApplicationRecord
  belongs_to :solar_system
  belongs_to :celestial_object
end
