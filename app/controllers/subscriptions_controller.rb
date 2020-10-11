class SubscriptionsController < ApplicationController
  def create
    I18n.locale = params[:locale] || I18n.default_locale

    user = User.create(email: params[:email], locale: locale)
    if user.valid?
      json = { message: I18n.t('subscribe.success') }
      status = 200
    else
      json = { message: user.errors.full_messages.to_sentence }
      status = 500
    end
    render json: json, status: status
  end
end
