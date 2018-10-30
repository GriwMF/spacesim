class Production < ApplicationRecord
  belongs_to :material
  belongs_to :factory

  enum type: %i[input output]

end
