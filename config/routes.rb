Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin' if Rails.env.development?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homepage#index'

  scope '/:locale' do
    resource :subscription, only: :create
  end
  resource :subscription, only: :create

  get '/:locale', to: 'homepage#index', as: :root_with_locale
end
