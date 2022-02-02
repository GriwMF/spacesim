class HistorySerializer < ActiveModel::Serializer
  attributes :id, :object_type, :object_id, :ship, :notify, :action, :params, :action_description

  # some bug? object_id doesn't work alone
  def object_id
    object.object_id
  end
end
