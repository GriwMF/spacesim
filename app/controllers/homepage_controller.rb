class HomepageController < ApplicationController
  def index
    render params[:id]
  end
end
