class SystemSerializer < ActiveModel::Serializer
  attributes :id, :name, :integrity, :power, :max_power, :oxygen, :max_oxygen, :consumption, :max_production

  def name
    object.type.split('::').last
  end

  def integrity
    object.integrity * 10
  end

  belongs_to :ship
end
