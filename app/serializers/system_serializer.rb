class SystemSerializer < ActiveModel::Serializer
  attributes :id, :name, :integrity

  def name
    object.type.split('::').last
  end

  belongs_to :ship
end
