class ShipSerializer < ActiveModel::Serializer
  attributes :id, :name, :integrity

  has_many :systems
end
