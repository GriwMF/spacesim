require 'matrix'

module HasPositionVector
  extend ActiveSupport::Concern

  def position_vector
    Vector[position_x, position_y, position_z]
  end

  def position_vector=(vector)
    self.position_x, self.position_y, self.position_z = vector.to_a
  end

  def move_towards(target, speed)
    direction = (target.position_vector - position_vector).normalize
    position_vector + (direction * speed)
  end

  def distance_to(target)
    (target.position_vector - position_vector).magnitude
  end
end
