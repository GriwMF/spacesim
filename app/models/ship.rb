class Ship < ApplicationRecord
  belongs_to :solar_system, optional: true
  belongs_to :celestial_object, optional: true
  belongs_to :target, optional: true, class_name: 'CelestialObject'
end
