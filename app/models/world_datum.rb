class WorldDatum < ApplicationRecord
  ARRIVED_DISTANCE = 25

  before_save :limit_step, if: :value

  def limit_step
    return unless key == 'step'

    self.value = 0 if value >= 1000
  end

  def self.step
    find_by(key: 'step')
  end

  def self.step_number
    step.value
  end
end
