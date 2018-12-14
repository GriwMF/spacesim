class HomepageController < ApplicationController
  def index
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def history

  end

  def bc
    ActionCable.server.broadcast("history", {id: 1, object: 'test'})
    head :ok
  end
end
