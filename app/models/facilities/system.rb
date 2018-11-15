module Facilities
  class System < ApplicationRecord
    self.abstract_class = true

    belongs_to :bay

    def step
      raise 'Not Implemented'
    end
  end
end
