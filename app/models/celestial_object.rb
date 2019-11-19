class CelestialObject < ApplicationRecord
  include HasPositionVector

  belongs_to :parent_object, optional: true, class_name: 'CelestialObject'

  has_many :factories, dependent: :destroy
  # no use for type yet
  # enum type: %i[planet sun]



end
