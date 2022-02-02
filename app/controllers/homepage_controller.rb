class HomepageController < ApplicationController
  def index
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def history
    @histories = ActiveModelSerializers::SerializableResource.new(History.all)
  end

  def bc
    ActiveRecord::Base.transaction do
      WorldDatum.step.update!(value: WorldDatum.step_number + 1)
      Factory.find_each(&:step)
      Ship.find_each(&:step)

    end

    Ship.broadcast_ships_info
    # History.find(493).notify_host_ship
    head :ok
  end

  def ship_data
    render json: Ship.all
  end
end
