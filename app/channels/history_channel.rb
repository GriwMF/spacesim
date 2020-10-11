class HistoryChannel < ApplicationCable::Channel
  def subscribed
    stream_from "history"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
