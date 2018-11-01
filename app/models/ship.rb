class Ship < ApplicationRecord
  has_many :stocks, as: :object
  belongs_to :solar_system, optional: true
  belongs_to :celestial_object, optional: true
  belongs_to :target, optional: true, class_name: 'CelestialObject'

  def step
    set_target unless target
    if progress > 100
      self.progress = 0
      process_action
    else
      self.progress += speed
    end
    save!
  end

  private

  def set_target
  end

  def process_action

  end
end
