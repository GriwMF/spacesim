class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def every(steps)
    (WorldDatum.step_number % steps).zero? && yield
  end

  def self.sample
    offset(Random.rand(count)).limit(1).take
  end
end
