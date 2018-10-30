class Factory < ApplicationRecord
  belongs_to :celestial_object
  has_many :productions

  enum type: %i[fuel matery construction]

end
