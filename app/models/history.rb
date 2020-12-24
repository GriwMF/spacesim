class History < ApplicationRecord
  belongs_to :object, polymorphic: true

  after_save do
    ActionCable.server.broadcast("history", self.to_json)
    notify_host_user if notify
  end

  def notify_host_user
    ActionCable.server.broadcast("history", self.action)
  end
end
