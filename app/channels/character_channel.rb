class CharacterChannel < ApplicationCable::Channel
  def subscribed
    character = Character.find(params[:id])
    stream_for character
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
