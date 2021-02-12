class History < ApplicationRecord
  belongs_to :object, polymorphic: true
  belongs_to :ship, optional: true

  after_save do
    ActionCable.server.broadcast("history", self.to_json)
    notify_host_ship if notify
  end

  def notify_host_ship
    JournalChannel.broadcast_to(object, action)
    # ActionCable.server.broadcast("history", self.action)
  end
end
