class HomepageController < ApplicationController
  def index
    I18n.locale = :ru
  end
end
