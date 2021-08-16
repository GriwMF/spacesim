class JournalChannel < ApplicationCable::Channel
  def subscribed
    ship = Ship.find(params[:id])
    stream_for ship
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
