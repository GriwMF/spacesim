class History < ApplicationRecord
  belongs_to :object, polymorphic: true

  after_save do
    ActionCable.server.broadcast("history", self.to_json)
    notify_host_ship if notify
  end

  def notify_host_ship
    o = object.respond_to?(:ship) ? object.ship : object
    JournalChannel.broadcast_to(o, action)
    # ActionCable.server.broadcast("history", self.action)
  end
end
