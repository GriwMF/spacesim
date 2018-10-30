class CelestialObject < ApplicationRecord
  belongs_to :parent_object, optional: true, class_name: 'CelestialObject'

  # no use for type yet
  # enum type: %i[planet sun]




end
