class ShipSerializer < ActiveModel::Serializer
  attributes :id, :name, :integrity, :current_action, :credits

  has_many :systems

  def current_action
    object.action_tables.last&.action_type
  end

  def credits
    object.credits.amount
  end
end
