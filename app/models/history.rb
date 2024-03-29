class History < ApplicationRecord
  belongs_to :object, polymorphic: true # an owner of the event
  belongs_to :ship, optional: true # outdated? Used in characters

  after_save do
    ActionCable.server.broadcast("history",  ActiveModelSerializers::SerializableResource.new(self).to_json)

    # notify_host_ship if notify  # noo need for this as events deprecated in favor of histories
  end

  def self.create_notification(ship, action, params = nil)
    self.create!(object: ship, action: action, params: params, notify: true)
  end

  #deprecated
  def notify_host_ship
    JournalChannel.broadcast_to(object, action_description)
    # ActionCable.server.broadcast("history", self.action)
  end

  # temp method to simply show action-to-text basics
  def action_description
    case action
    when 'took_damage'
      "Ship #{object.name} took #{params['damage']} damage"
    when 'fired'
      "Ship #{object.name} hit #{params['ship']['name']} for #{params['damage']} points with #{params['shots_done'].size} shot(s)"
    when 'system_destroy'
      "Ship #{object.name} is destroyed"
    else
      action
    end
  end
end
