class HomepageController < ApplicationController
  def index
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def history
    @histories = History.all
  end

  def bc
    ActiveRecord::Base.transaction do
      WorldDatum.step.update!(value: WorldDatum.step_number + 1)
      Factory.find_each(&:step)
      Ship.find_each(&:step)
      Character.find_each(&:step)
    end
    head :ok
  end
end
